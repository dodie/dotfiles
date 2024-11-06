#!/usr/bin/env python

import sys
import os
import subprocess

def get_git_commits(repo_path):
    """Get the list of all commits (in reverse order) from a Git repository."""
    try:
        commits = subprocess.check_output(
            ['git', 'rev-list', '--all'],
            cwd=repo_path,
            text=True
        ).splitlines()
        return commits
    except subprocess.CalledProcessError as e:
        print(f"Error: Unable to get commits for {repo_path}. {e}")
        return []

def find_last_common_commit(commits_repo1, commits_repo2):
    """Find the last common commit between two lists of commits."""
    for commit1 in commits_repo1:
        if commit1 in commits_repo2:
            return commit1
    return None

def main(repo1_path, repo2_path):
    commits_repo1 = get_git_commits(repo1_path)
    commits_repo2 = get_git_commits(repo2_path)

    common_commit = find_last_common_commit(commits_repo1, commits_repo2)

    if common_commit:
        print(f"The last common commit in the two repositories is: {common_commit}")
    else:
        print("No common commit found.")

if __name__ == "__main__":
    repo1_path = sys.argv[1]
    repo2_path = sys.argv[2]
    print("Looking for the last common commit in the following repositories:")
    print(f" {repo1_path}")
    print(f" {repo2_path}")

    if not os.path.isdir(repo1_path) or not os.path.isdir(repo2_path):
        print("Error: One or both of the repository paths do not exist or are not valid directories.")
    else:
        main(repo1_path, repo2_path)
