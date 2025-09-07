# Computational Intelligence

## Table of contents

- [Computational Intelligence](#computational-intelligence)
  - [Table of contents](#table-of-contents)
  - [Installation and execution](#installation-and-execution)

## Installation and execution

```bash
cd docker_images/comp_int_container
sudo docker compose up -d --build --remove-orphans
xhost +local:docker
sudo docker exec -it comp_int_container bash
python3 tarea1.py # to be ran on the same terminal that your ran the last command.
```
