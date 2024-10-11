#! /usr/bin/env python

# Show which repositories match the given search term.
# Excludes forks and personal repositories.
#
# From an user point of view it's almost identical to bitbucket-search.sh,
# the difference is an implementation detail how the search API is called.
#  - bitbucket-search.sh performs a single (paginated) search based on the search term
#    if there are more than 1000 results, this method fails. (Note: it also fails
#    on the UI: if you scroll down to the 1001th result of a search, it will display an error.)
#  - bitbucket-search-slow.sh works around this issue by performing a dedicated search
#    for each repository in the system.
#
# Use bitbucket-search.sh in most cases, use this one if that fails.
# 
# Args:
#  - Personal Access Token
#  - seach query
#
import os
import sys
import json
import urllib.request
import urllib.error

# Utility function to handle the Bitbucket API requests
def bitbucket_api_get(endpoint, bitbucket_token, start=0, page_size=1000):
    url = f"{BITBUCKET_URL}/rest/api/1.0/repos/?limit={page_size}&start={start}"
    headers = {
        'Authorization': f'Bearer {bitbucket_token}',
        'Content-Type': 'application/json',
        'Accept': 'application/json, text/javascript, */*; q=0.01'
    }

    request = urllib.request.Request(url, headers=headers, method="GET")
    
    try:
        with urllib.request.urlopen(request) as response:
            return response.read().decode('utf-8')
    except urllib.error.HTTPError as e:
        print(f"HTTP Error: {e.code} {e.reason}", file=sys.stderr)
        print(e.read().decode('utf-8'), file=sys.stderr)
    except urllib.error.URLError as e:
        print(f"URL Error: {e.reason}", file=sys.stderr)
    return None

# Parse the API response to extract the repository details
def parse_api_response(response):
    try:
        response_json = json.loads(response)
        return [repo for repo in response_json.get("values", [])]
    except json.JSONDecodeError:
        print("Error parsing the JSON response.", file=sys.stderr)
        return []

# Perform recursive repository querying to handle paging
def query_repositories(bitbucket_token, start=0, page_size=1000):
    response = bitbucket_api_get("repos", bitbucket_token, start, page_size)
    if response:
        repos = parse_api_response(response)
        is_last_page = json.loads(response).get("isLastPage", True)
        
        if not is_last_page:
            next_start = json.loads(response).get("nextPageStart", 0)
            repos += query_repositories(bitbucket_token, next_start, page_size)
        return repos
    return []

# Search repository content using the provided query and print the matches
def search_repo(bitbucket_token, repo, search_term):
    key = repo.get('slug')
    project = repo.get('project', {}).get('key')

    search_query = f"project:{project} repo:{key} {search_term}"
    url = f"{BITBUCKET_URL}/rest/search/latest/search"
    
    headers = {
        'Authorization': f'Bearer {bitbucket_token}',
        'Content-Type': 'application/json',
        'Accept': 'application/json, text/javascript, */*; q=0.01'
    }

    payload = json.dumps({
        "query": search_query,
        "entities": {
            "code": {
                "start": 0,
                "limit": 1
            }
        }
    }).encode('utf-8')

    request = urllib.request.Request(url, headers=headers, data=payload, method="POST")
    
    try:
        with urllib.request.urlopen(request) as response:
            response_json = json.loads(response.read().decode('utf-8'))
            for result in response_json.get('code', {}).get('values', []):
                print(json.dumps({
                    "project": result['repository']['project']['key'],
                    "name": result['repository']['name']
                }))
    except urllib.error.HTTPError as e:
        print(f"HTTP Error: {e.code} {e.reason}", file=sys.stderr)
    except urllib.error.URLError as e:
        print(f"URL Error: {e.reason}", file=sys.stderr)

# Main logic of the script
def main(bitbucket_token, search_term):
    # Query all repositories and perform the search for each
    repos = query_repositories(bitbucket_token)
    for repo in repos:
        search_repo(bitbucket_token, repo, search_term)

if __name__ == "__main__":
    # Check for the required environment variables
    BITBUCKET_URL = os.getenv('BITBUCKET_URL')
    BITBUCKET_TOKEN = os.getenv('BITBUCKET_TOKEN')
    
    if not BITBUCKET_URL:
        print("Error: BITBUCKET_URL environment variable is missing.", file=sys.stderr)
        sys.exit(1)
    
    if not BITBUCKET_TOKEN:
        print("Error: BITBUCKET_TOKEN environment variable is missing.", file=sys.stderr)
        sys.exit(1)

    # Check if the search query is passed as the first argument
    if len(sys.argv) < 2:
        print("Error: Search query is missing.", file=sys.stderr)
        sys.exit(1)
    
    SEARCH_TERM = sys.argv[1]
    
    main(BITBUCKET_TOKEN, SEARCH_TERM)
