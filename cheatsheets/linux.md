## Basic Commands

- `ls`: List files and directories in the current directory.
  - `ls -l`: List files and directories in long format.
  - `ls -a`: List all files, including hidden files.

- `cd`: Change the current directory.
  - `cd ..`: Go up one directory level.
  - `cd /path/to/directory`: Change to a specific directory.

- `pwd`: Print the current working directory.

- `cat`: Display the contents of a file.
  - `cat file.txt`: Display the contents of `file.txt`.

- `echo`: Print a message or value.
  - `echo "Hello, World!"`: Print "Hello, World!" to the console.

- `cp`: Copy files and directories.
  - `cp file.txt destination/`: Copy `file.txt` to the `destination/` directory.

- `mv`: Move or rename files and directories.
  - `mv file.txt new_location/`: Move `file.txt` to the `new_location/` directory.
  - `mv file.txt new_name.txt`: Rename `file.txt` to `new_name.txt`.

- `mkdir`: Create a new directory.
  - `mkdir new_directory`: Create a directory named `new_directory`.

- `rm`: Remove files and directories.
  - `rm file.txt`: Remove `file.txt`.
  - `rm -r directory/`: Remove the `directory/` and its contents recursively.

- `grep`: Search for patterns in files.
  - `grep "pattern" file.txt`: Search for "pattern" in `file.txt`.
  - `grep -r "pattern" directory/`: Search for "pattern" recursively in `directory/`.

- `sed`: Stream editor for filtering and transforming text.
  - `sed 's/old/new/g' file.txt`: Replace all occurrences of "old" with "new" in `file.txt`.

- `awk`: Text processing tool for manipulating structured data.
  - `awk '{print $1}' file.txt`: Print the first column of each line in `file.txt`.

- `tar`: Archive and compress files.
  - `tar -cvf archive.tar directory/`: Create a tar archive of `directory/`.
  - `tar -xvf archive.tar`: Extract the contents of `archive.tar`.

- `gzip`: Compress files.
  - `gzip file.txt`: Compress `file.txt` into `file.txt.gz`.

- `unzip`: Extract compressed files.
  - `unzip file.zip`: Extract the contents of `file.zip`.

- `ssh`: Securely connect to a remote server.
  - `ssh user@host`: Connect to `host` as `user`.

- `scp`: Securely copy files between hosts.
  - `scp file.txt user@host:/path/`: Copy `file.txt` to `/path/` on `host` as `user`.

- `ps`: Display information about running processes.
  - `ps aux`: Display all running processes.

- `top`: Monitor system resource usage and processes in real-time.

- `free`: Display memory usage information.
  - `free -h`: Display memory usage in human-readable format.

- `df`: Display disk space usage.
  - `df -h`: Display disk space usage in human-readable format.

- `du`: Estimate file and directory space usage.
  - `du -sh directory/`: Display the total size of `directory/` in human-readable format.

- `netstat`: Display network connections and statistics.
  - `netstat -tuln`: Display listening ports and associated processes.

- `iptables`: Configure firewall rules.
  - `iptables -L`: List current firewall rules.

- `systemctl`: Control system services.
  - `systemctl start service`: Start `service`.
  - `systemctl stop service`: Stop `service`.
  - `systemctl status service`: Check the status of `service`.


## File Permissions

- `chmod`: Change the permissions of files and directories.
  - `chmod +x script.sh`: Add execute permission to `script.sh` for the current user.
  - `chmod 644 file.txt`: Set read and write permissions for the owner, and read permissions for group and others on `file.txt`.

- `chown`: Change the owner and group ownership of files and directories.
  - `chown user:group file.txt`: Change the owner of `file.txt` to `user` and the group to `group`.

- `umask`: Set the default file permissions for newly created files and directories.
  - `umask 022`: Set the default permissions to allow read and write for the owner, and read for group and others.

## Archives and Compression

- `zip`: Create a compressed archive of files and directories.
  - `zip archive.zip file1.txt file2.txt`: Create a ZIP archive named `archive.zip` containing `file1.txt` and `file2.txt`.

- `unzip`: Extract files from a ZIP archive.
  - `unzip archive.zip`: Extract the contents of `archive.zip` in the current directory.

- `tar`: Create or extract tar archives, optionally with compression.
  - `tar -czvf archive.tar.gz directory/`: Create a compressed tar archive named `archive.tar.gz` containing `directory/`.
  - `tar -xzvf archive.tar.gz`: Extract the contents of `archive.tar.gz` in the current directory.

## System Resource Monitoring

- `vmstat`: Display virtual memory statistics.
  - `vmstat 5`: Display virtual memory statistics every 5 seconds.

- `iostat`: Monitor input/output statistics for devices and partitions.
  - `iostat -x 2`: Display extended I/O statistics every 2 seconds.

- `sar`: Collect and report system activity information.
  - `sar -u 1 5`: Display CPU usage every 1 second for 5 times.

## Scheduling Tasks

- `crontab`: Schedule tasks to run at specific times or intervals.
  - `crontab -e`: Edit the current user's crontab file to add or modify scheduled tasks.

- `at`: Schedule a one-time task to run at a specified time.
  - `echo "command" | at 10:00 AM`: Schedule `command` to run at 10:00 AM.

## Shell Scripting

- `#!/bin/bash`: Shebang line to specify the interpreter for a Bash script.

- `echo`: Print a message or value.
  - `echo "Hello, World!"`: Print "Hello, World!" to the console.

- `read`: Read input from the user.
  - `read name`: Read input from the user and store it in the `name` variable.

- `if`, `else`, `elif`: Conditional statements for flow control.
  - `if [ condition ]; then commands; fi`: Execute `commands` if `condition` is true.

- `for`, `while`: Looping constructs for repetitive tasks.
  - `for i in 1 2 3; do echo $i; done`: Print numbers 1, 2, and 3 using a `for` loop.

## Miscellaneous

- `history`: Display the command history.
  - `history`: Show the list of previously executed commands.

- `man`: Display the manual page for a command.
  - `man ls`: Show the manual page for the `ls` command.

- `sudo`: Execute a command with superuser privileges.
  - `sudo apt update`: Run the `apt update` command with superuser privileges.

- `touch`: Create an empty file or update the timestamp of an existing file.

- `touch new_file.txt`: Create a new empty file named new_file.txt.

- `head`: Display the first few lines of a file.
    - `head -n 10 file.txt`: Display the first 10 lines of file.txt.

- `tail`: Display the last few lines of a file.
    - `tail -n 10 file.txt`: Display the last 10 lines of file.txt.
    - `tail -f log_file.txt`: Continuously display the last lines of log_file.txt as it grows.

- `less`: View the contents of a file interactively.
    - `less file.txt`: Open file.txt in the less pager for scrolling and searching.

- `find`: Search for files and directories based on various criteria.
    - `find . -name "*.txt"`: Find all files with the .txt extension in the current directory and its subdirectories.

- `du`: Estimate file and directory space usage.
    - `du -sh *`: Display the size of each file and directory in the current directory 
in human-readable format.

## Process Management

- `kill`: Send a signal to a process to terminate it.
    -`kill PID`: Terminate the process with the specified PID.

- `pkill`: Send a signal to processes based on their name.
    -`pkill process_name`: Terminate all processes with the name process_name.

- `bg`: Put a suspended process in the background.
    -`bg %1`: Put the suspended job with job ID 1 in the background.

- `fg`: Bring a background process to the foreground.
    -`fg %1`: Bring the background job with job ID 1 to the foreground.

## System Information
- `uname`: Display system information.
    - `uname -a`: Display all system information.

- `lsb_release`: Display Linux distribution-specific information.
    - `lsb_release -a`: Display all distribution-specific information.

- `uptime`: Show how long the system has been running.

- `whoami`: Display the current user's username.

- `hostname`: Display the system's hostname.

- `df`: Display disk space usage.
    -`df -h`: Display disk space usage in human-readable format.

## Network Commands
- `ping`: Test network connectivity to a host.
    - `ping google.com`: Test connectivity to google.com.

- `traceroute`: Trace the route packets take to a host.
    - `traceroute google.com`: Trace the route to google.com.

- `curl`: Transfer data from or to a server using various protocols.
    - `curl https://example.com`: Retrieve the content of https://example.com.

- `ifconfig`: Configure network interfaces.
    - `ifconfig`: Display information about active network interfaces.

## Text Processing
- `sort`: Sort lines of text.
    - `sort file.txt`: Sort the lines in file.txt alphabetically.

- `uniq`: Remove or identify duplicate lines.
    - `uniq file.txt`: Remove consecutive duplicate lines from file.txt.

- `cut`: Extract columns from each line of text.
    - `cut -d ',' -f 1 file.csv`: Extract the first column (field) from file.csv using comma as the delimiter.

- `wc`: Count lines, words, and characters in a file.
    - `wc -l file.txt`: Count the number of lines in file.txt.

## Network Troubleshooting

- `nslookup`: Query DNS servers to obtain domain name or IP address mapping.
  - `nslookup example.com`: Get the IP address of `example.com`.

- `dig`: Query DNS servers for detailed information about a domain.
  - `dig example.com`: Get detailed DNS information about `example.com`.

- `telnet`: Establish a telnet connection to a remote host.
  - `telnet example.com 80`: Establish a telnet connection to `example.com` on port 80.

- `nc` (netcat): Versatile utility for network communication and debugging.
  - `nc -zv example.com 80`: Check if port 80 is open on `example.com`.

## File Comparison and Patching

- `diff`: Compare files line by line.
  - `diff file1.txt file2.txt`: Show the differences between `file1.txt` and `file2.txt`.

- `patch`: Apply a patch file to update source code or text files.
  - `patch < patch_file.patch`: Apply the changes described in `patch_file.patch` to the corresponding files.

## Text Searching

- `grep`: Search for patterns in files.
  - `grep -r "pattern" directory/`: Search for "pattern" recursively in `directory/`.
  - `grep -i "pattern" file.txt`: Perform a case-insensitive search for "pattern" in `file.txt`.

- `egrep`: Extended version of `grep` with support for more advanced pattern matching.
  - `egrep -o 'pattern|pattern2' file.txt`: Search for multiple patterns in `file.txt` and only print the matching parts.

## File Integrity

- `md5sum`: Calculate the MD5 checksum of a file.
  - `md5sum file.txt`: Display the MD5 checksum of `file.txt`.

- `sha256sum`: Calculate the SHA-256 checksum of a file.
  - `sha256sum file.txt`: Display the SHA-256 checksum of `file.txt`.

## System Maintenance

- `lsof`: List open files and the processes using them.
  - `lsof -i :80`: List processes using port 80.

- `watch`: Execute a command periodically and display the output.
  - `watch -n 5 'command'`: Execute `command` every 5 seconds and display the output.

- `dmesg`: Display kernel ring buffer messages.
  - `dmesg | tail`: Display the last few kernel messages.

## User and Group Management

- `useradd`: Create a new user account.
  - `useradd -m john`: Create a new user account named "john" with a home directory.

- `passwd`: Change the password for a user account.
  - `passwd john`: Change the password for the user "john".

- `groupadd`: Create a new group.
  - `groupadd developers`: Create a new group named "developers".

- `usermod`: Modify a user account.
  - `usermod -aG developers john`: Add the user "john" to the "developers" group.

## Disk Usage

- `ncdu`: Interactive disk usage analyzer.
  - `ncdu /path/to/directory`: Analyze disk usage in `/path/to/directory` interactively.

- `iostat`: Report CPU and I/O statistics for devices and partitions.
  - `iostat -m 2`: Display I/O statistics in megabytes every 2 seconds.