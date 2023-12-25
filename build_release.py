import yaml
import os
import stat

from jinja2 import Environment, FileSystemLoader

with open("versions.yml") as f:
    versions = yaml.safe_load(f)

environment = Environment(loader=FileSystemLoader("templates/"))

templates = [
    "requirements.txt",
    "cdsp_conda.yml",
    "full_install_venv.sh",
    "full_install_conda.sh",
    "full_install_poetry.sh",
    "full_install_venv.bat",
    "full_install_conda.bat",
    "pyproject.toml",
]

for template in templates:
    t = environment.get_template(template + ".j2")

    # render and write
    rendered = t.render(versions)
    rendered_name = os.path.join("output", template)
    with open(rendered_name, mode="w", encoding="utf-8") as f:
        f.write(rendered)

    # make shell scripts executable
    if rendered_name.endswith(".sh"):
        file_stat = os.stat(rendered_name)
        os.chmod(rendered_name, file_stat.st_mode | stat.S_IXUSR | stat.S_IXGRP | stat.S_IXOTH)