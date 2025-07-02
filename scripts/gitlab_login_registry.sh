# Replace with your actual token and username
export GITLAB_TOKEN="glpat-" # complete
export GITLAB_USER="oauth" # always the same

# Use --password-stdin to securely pass the token
echo "$GITLAB_TOKEN" | docker login registry.gitlab.com -u "$GITLAB_USER" --password-stdin
