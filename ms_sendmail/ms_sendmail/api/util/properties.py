import os, configparser
from pathlib import Path

def load_properties(base_dir):
    #Cargar Properties
    config = configparser.ConfigParser()
    configPath = os.path.join(base_dir, 'sources', 'properties', 'ConfigFile.properties')
    print('load configPath: {0}'.format(configPath))
    config.read(configPath)
    return config