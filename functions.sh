#!/bin/bash

git_work() {
    name="$1"
    version="$2"
    file_to_edit="$name.txt"
    date >> "$file_to_edit"
    git add "$file_to_edit"
    git commit -m "$name.$version"
}

git_feature_start() {
    # starts feature and makes two commits.
    feature_name="$1"
    file_to_edit="$feature_name.txt"
    git checkout -b "$feature_name" master
    date >> "$file_to_edit"
    git add "$file_to_edit"
    git commit -m "$feature_name.a"
    date >> "$file_to_edit"
    git add "$file_to_edit"
    git commit -m "$feature_name.b"
}

git_feature_end() {
    # merges feature back to master. and removes feature branch.
    feature_name="$1"
    git checkout "$feature_name"
    git rebase master
    git checkout master
    git merge --no-ff -m "Merge $feature_name" "$feature_name"
    git branch -d "$feature_name"

}

git_release() {
    version="$1"
    git checkout master
    git tag "$version"
}

git_hotfix_start() {
    hotfix_name="$1"
    version="$2"
    file_to_edit="$hotfix_name.txt"
    git checkout -b "$hotfix_name" "$version"
    date >> "$file_to_edit"
    git add "$file_to_edit"
    git commit -m "$hotfix_name.a"
    date >> "$file_to_edit"
    git add "$file_to_edit"
    git commit -m "$hotfix_name.b"
}

git_hotfix_end() {
    hotfix_name="$1"
    version="$2"
    git checkout "$hotfix_name"
    git tag "$version"
    git rebase master
    git checkout master
    git merge --no-ff -m "Merge $hotfix_name" "$hotfix_name"
    git branch -d "$hotfix_name"
}


