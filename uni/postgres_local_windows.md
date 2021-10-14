# Running PostgreSQL on Windows 10 using Docker

**THIS DOC ONLY COVERS ON SETTING UP POSTGRESQL ON WINDOWS 10 / WINDOWS 11 USING DOCKER.**

## Prerequisites
 * Windows 10 (build 18362 or higher) or Windows 11 (all builds). Use ``winver`` to check your build number if needed.

## Setup process
 1. Install WSL2 on your system - read one of the following documents from Microsoft.
    * [Quick Install (build 19041 or higher)](https://docs.microsoft.com/en-us/windows/wsl/install)
    * [Manual Install (build 18362 or higher)](https://docs.microsoft.com/en-us/windows/wsl/install-manual)
 2. Install Docker Desktop with WSL 2 backend enabled: see this [documentation](https://docs.docker.com/desktop/windows/wsl/) from Docker.
 3. In ``cmd``, run
    ```
    docker pull postgres
    ```
    This downloads and sets up the [official image](https://hub.docker.com/_/postgres) of PostgreSQL from Docker Hub.


## Accessing PostgreSQL from WSL Distro
 1. Run your Linux Distro (Ubuntu by default) from Start Menu. This gives access to WSL ``bash``. Set username and password if you haven't already.
 2. Install ``git`` and ``psql`` with the following command in Ubuntu:
    ```
    sudo apt install git postgresql-client
    ```
    ``git`` is a dependency for getting data files from GitHub and ``postgresql-client`` is a requirement for connecting to PostgreSQL
     * (Optional) Install ``jq`` with following command in Ubuntu:
        ```
        sudo apt install jq
        ```
        This is a dependency for using ``pq_get_ip.sh``.
        If you are running a different distribution that does not use ``apt``, check [here](https://stedolan.github.io/jq/download/).
 3. Continue your setup with [step 2](postgres_docker.md#Step_2:_Get_files_from_github) of [postgres_docker.md](postgres_docker.md).

## Known issues
* Accessing PostgreSQL from inside a WSL distro is a pain. A quick workaround for this is specifying the port when executing ``docker run`` with ``-p "5432:5432"``. This workaround makes docker container visible to both Windows and WSL distro - use ``127.0.0.1`` or ``localhost`` as your IP address when connecting to PostgreSQL. You can use ``start_pg_wsl.sh`` which has this workaround applied instead of ``start_pg.sh``.