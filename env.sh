export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

git_setup() {
    cat <<-EOF >$HOME/.netrc
        machine github.com
        login $GITHUB_ACTOR
        password $GITHUB_TOKEN
        machine api.github.com
        login $GITHUB_ACTOR
        password $GITHUB_TOKEN
EOF
    chmod 600 $HOME/.netrc
    git config --global user.email "$INPUT_AUTHOR_EMAIL"
    git config --global user.name "$INPUT_AUTHOR_NAME"
}

git_setup

git fetch

# Verify if the branch needs to be created
if ! git rev-parse --verify --quiet "$GITHUB_REF"; then
    echo "Creating branch..."
    git branch "$GITHUB_REF"
fi

# Switch to branch from current workflow run
echo "Switching branch..."
git checkout "$GITHUB_REF"