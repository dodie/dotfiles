#! /usr/bin/env python


# Bitbucket search (exact, excluding forks)
#
# Required environment variables:
#  - BITBUCKET_TOKEN
#  - BITBUCKET_URL

# Args:
#  - seach query

#
# Example:
#   export BITBUCKET_URL="https://my.bitbucket.host/bitbucket"
#   read -rs BITBUCKET_TOKEN
#   export BITBUCKET_TOKEN
#   ./bitbucket-search.py "hello world"
#
# TODO
# - param to toggle fork:false, or just don't do it
# - help cmd to print bitbucket search options as a handy reference
# - param to exclude personal repos. Or a handy jq/grep expression such as
#  -  To exclude all personal projects pipe into `grep -v '{"project":"~'`
# - param to include actual search results
#  - For this reason the cmd above probably should be jq.
#  - or by default it should show the search results, and give here a handy jq expression to hide them

import os
import sys
import json
import urllib.request
import urllib.error

class TooManyResultsException(Exception):
    pass

def search(bitbucket_token, query, bitbucket_url, start=0, force=False):
    url = f"{bitbucket_url}/rest/search/latest/search"

    headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json, text/javascript, */*; q=0.01',
        'Authorization': f'Bearer {bitbucket_token}'
    }

    payload = json.dumps({
        "query": f"\"{query}\" fork:false",
        "entities": {
            "code": {
                "start": start,
                "limit": 25
            }
        }
    }).encode('utf-8')

    request = urllib.request.Request(url, data=payload, headers=headers, method="POST")

    try:
        with urllib.request.urlopen(request) as response:
            response_data = response.read().decode('utf-8')
            response_json = json.loads(response_data)

            if start == 0 and response_json['code']['count'] > 1000 and not force:
                raise TooManyResultsException()

            for repo in response_json['code']['values']:
                project = repo['repository']['project']['key']
                name = repo['repository']['name']
                print(f"{{'project': '{project}', 'name': '{name}'}}")

            if not response_json['code']['isLastPage']:
                next_start = response_json['code']['nextStart']
                search(bitbucket_token, query, bitbucket_url, next_start)

    except urllib.error.HTTPError as e:
        print(f"HTTP Error: {e.code} {e.reason}", file=sys.stderr)
        print(e.read().decode('utf-8'), file=sys.stderr)
    except urllib.error.URLError as e:
        print(f"URL Error: {e.reason}", file=sys.stderr)


def slow_search(bitbucket_token, query, bitbucket_url, start=0):
    print("Too many results")
    sys.exit(1)

def ask_confirmation():
    while True:
        print("The query yields more than 1000 results, so not all results can be displayed.", file=sys.stderr)
        response = input("[C]ontinue / [S]witch to slower per repository search / [A]bort ").strip().lower()
        if response in ['c', 's', 'a']:
            return response
        else:
            print("Please enter 'c', 's' or 'a'", file=sys.stderr)

if __name__ == "__main__":
    BITBUCKET_URL = os.getenv('BITBUCKET_URL')
    BITBUCKET_TOKEN = os.getenv('BITBUCKET_TOKEN')

    if not BITBUCKET_URL:
        print("Error: BITBUCKET_URL environment variable is missing.", file=sys.stderr)
        sys.exit(1)

    if not BITBUCKET_TOKEN:
        print("Error: BITBUCKET_TOKEN environment variable is missing.", file=sys.stderr)
        sys.exit(1)

    if len(sys.argv) < 2:
        print("Error: Supply the search query as parameter.", file=sys.stderr)
        sys.exit(1)

    QUERY = sys.argv[1]

    try:
        try:
            search(BITBUCKET_TOKEN, QUERY, BITBUCKET_URL)
        except TooManyResultsException:
            mode = ask_confirmation()
            if mode == 'c':
                search(BITBUCKET_TOKEN, QUERY, BITBUCKET_URL, force=True)
            elif mode == 's':
                slow_search(BITBUCKET_TOKEN, QUERY, BITBUCKET_URL)
            else:
                print("Aborting", file=sys.stderr)
    except KeyboardInterrupt:
        pass



