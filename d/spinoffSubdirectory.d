#!/usr/bin/env rdmd

import std.stdio;
import std.getopt;
import std.algorithm;
import std.string;
import std.utf;
import std.process;
import std.format;
import std.typecons;

const string ORIGINAL_REPO_NAME = "git@github.com:RayMPerry/prototypes.git";

bool printAndValidate(Tuple!(int, "status", string, "output") executedCommand) {
  writeln(executedCommand.output);
  return executedCommand.status == 0;
}

int spinoffSubdirectory(string folderName, string branchName, string repoName) {
  writeln("Spinning off subdirectory.");

  auto commandsToRun = [["git", "filter-branch", "-f", "--prune-empty", "--subdirectory-filter", folderName, branchName],
                        ["git", "remote", "set-url", "origin", repoName],
                        ["git", "push", "-u", "origin", "master"],
                        ["git", "remote", "set-url", "origin", ORIGINAL_REPO_NAME],
                        ["git", "fetch", "--all"],
                        ["git", "reset", "--hard", "origin/master"]];

  bool isPreviousCommandSuccessful = false;
  foreach (command; commandsToRun) {
    isPreviousCommandSuccessful = printAndValidate(execute(command));
    if (!isPreviousCommandSuccessful) return 1;
  }

  return 0;
}

int main(string[] args) {
  string FOLDER_NAME, BRANCH_NAME, REPO_NAME;

  getopt(args,
         "folder", &FOLDER_NAME,
         "branch", &BRANCH_NAME,
         "repo", &REPO_NAME);

  if ([FOLDER_NAME.length, BRANCH_NAME.length, REPO_NAME.length].any!`a < 1`) {
    writeln("--folder, --branch, and --repo must be specified.");
    return 1;
  }
  
  writef("Would you like to spinoff %s from %s into %s? [y/N] ", FOLDER_NAME, BRANCH_NAME, REPO_NAME);
  if (readln().chomp().among("y", "Y")) return spinoffSubdirectory(FOLDER_NAME, BRANCH_NAME, REPO_NAME);
  return 0;
}
