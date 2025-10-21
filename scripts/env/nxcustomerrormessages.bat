@echo off


REM This script accepts any of the following IDs as input parameters.
REM
REM The custom message specified in the script will be displayed at the end of the NoMachine default message and will be not translated.
REM
REM The list of the customizable messages and their ID is:
REM
REM 1  - Reached the maximum number of concurrent virtual sessions on all nodes.
REM 2  - Reached the maximum number of concurrent virtual sessions on this server.
REM 3  - Maximum number of virtual sessions reached for user: <user>.
REM 4  - Reached the maximum number of concurrent virtual sessions on node <node>.
REM 5  - Reached the maximum number of concurrent sessions on this server.
REM 6  - Reached the maximum number of concurrent sessions on node <node>.
REM 7  - Reached the maximum number of allowed users on this server.
REM 8  - Not enough X resources.
REM 9  - Reached the maximum number of concurrent guest users on this server.
REM 10 - Reached the maximum number of allowed guests.
REM 11 - Reached the maximum number of sessions for this guest user.

SET /a messageId=%1

if %messageId% GEQ 1 (
    if %messageId% LEQ 11 (
        echo Custom message
    )
)

exit 0