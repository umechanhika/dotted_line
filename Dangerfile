if !git.modified_files.include?("pubspec.yaml")
    fail("Please include a pubspec.yaml entry. Update to a new version is required.")
end

if !git.modified_files.include?("CHANGELOG.md")
    fail("Please include a CHANGELOG.md entry. The new version must be listed.")
end