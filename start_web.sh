#!/bin/bash

# Define the path to your virtual environment's activate script
VENV_PATH="$HOME/Projects/Artworks/myenv/bin/activate"

# Define the path to your Flask application file
APP_PATH="$HOME/Projects/Artworks/app.py"

# Define the log file name
LOG_FILE="$HOME/Projects/Artworks/output.log"

# Check if the virtual environment activate script exists
if [ ! -f "$VENV_PATH" ]; then
  echo "Error: Virtual environment activation script not found at '$VENV_PATH'."
  echo "Please ensure the path is correct and the virtual environment is set up."
  exit 1
fi

# Run the activation and nohup command in a subshell
(
  source "$VENV_PATH"
  cd "$(dirname "$APP_PATH")"
  nohup python "$(basename "$APP_PATH")" > "$LOG_FILE" 2>&1 &
  echo "Flask application started in the background (within the virtual environment subshell)."
  echo "Check logs in '$LOG_FILE'."
  PID=$!
  echo "Process ID (PID): $PID"
  echo "You can stop the process using: kill $PID"
)

exit 0
