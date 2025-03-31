import os
def load_config():
    config = {}
    path = os.path.join('env', 'config.txt')
    with open(path, 'r') as file:
        for line in file:
            key, value = line.strip().split('=')
            config[key.strip()] = value.strip()
    return config