# Game Save Repository

A bash script for automatically backing up game save files to a GitHub repository using the GitHub CLI.

## Features

- 🎮 Backup game saves to a centralized GitHub repository
- 🔄 Automatic synchronization with rsync
- 📝 Timestamped commit messages
- 🚀 Auto-creates repository if it doesn't exist
- 🧹 Cleans up nested .git directories to prevent conflicts
- ⚡ Only commits when there are actual changes

## Prerequisites

- [GitHub CLI (gh)](https://cli.github.com/) installed and authenticated
- `git` installed and configured
- `rsync` available on your system
- Bash shell

## Installation

1. Clone or download the script
2. Make it executable:
   ```bash
   chmod +x game_save_script.sh
   ```
3. Optionally, move it to your PATH for global access:
   ```bash
   sudo mv game_save_script.sh /usr/local/bin/game-save
   ```

## Usage

```bash
./game_save_script.sh <GAME_NAME> <SOURCE_PATH>
```

### Parameters

- `GAME_NAME`: Name of the game (will be used as folder name in the repo)
- `SOURCE_PATH`: Path to the game save directory you want to backup

### Examples

```bash
# Backup Minecraft saves
./game_save_script.sh minecraft ~/.minecraft/saves

# Backup Steam game saves
./game_save_script.sh "my-game" ~/.steam/steam/userdata/123456789/12345/remote

# Backup with custom game name
./game_save_script.sh "skyrim-modded" "/path/to/skyrim/saves"
```

## How It Works

1. **Repository Setup**: Checks if the `game_save` repository exists locally
   - If not found locally, attempts to clone from GitHub
   - If repository doesn't exist on GitHub, creates it automatically

2. **Save Synchronization**: Uses `rsync` to sync save files
   - Creates target directory if needed
   - Mirrors source directory (including deletions)
   - Preserves file permissions and timestamps

3. **Git Operations**: 
   - Removes any nested `.git` directories to prevent conflicts
   - Stages changes for the specific game
   - Only commits if there are actual changes
   - Pushes to the `main` branch

4. **Commit Messages**: Automatically generates timestamped commit messages:
   ```
   Update save for minecraft (2024-01-15 14:30:22)
   ```

## Configuration

The script uses these default values (modify at the top of the script if needed):

- `USER`: GitHub username (currently set to `yumanuralfath`)
- `REPO_NAME`: Repository name (currently set to `game_save`)
- `REPO_DIR`: Local repository path (currently `~/game_save`)

## Repository Structure

Your backup repository will be organized like this:

```
game_save/
├── minecraft/
│   ├── world1/
│   └── world2/
├── skyrim/
│   ├── save1.ess
│   └── save2.ess
└── another-game/
    └── save_files/
```

## Error Handling

The script includes basic error handling:
- Exits if it can't navigate to the repository directory
- Silently handles cases where cached files don't exist
- Reports when no changes are detected

## Notes

- The script will overwrite existing files in the target directory
- Make sure your source paths don't contain sensitive information
- The repository is created as public by default (modify the script to change this)
- Large save files may take time to upload depending on your connection

## Troubleshooting

### "gh: command not found"
Install the GitHub CLI from [cli.github.com](https://cli.github.com/)

### "Permission denied"
Make sure the script is executable: `chmod +x game_save_script.sh`

### Authentication issues
Run `gh auth login` to authenticate with GitHub

### Repository not found
Ensure your GitHub username is correctly set in the `USER` variable

## License

This script is provided as-is for personal use. Feel free to modify and distribute according to your needs.