import yaml
from os.path import join
from jinja2 import Environment, FileSystemLoader

with open("versions.yml") as f:
    versions = yaml.safe_load(f)

environment = Environment(loader=FileSystemLoader("templates/"))

templates = [
    "requirements.txt",
    "cdsp_conda.yml",
    "install_venv.sh",
    "install_conda.sh",
    "install_venv.bat",
    "install_conda.bat",
]

for template in templates:
    t = environment.get_template(template + ".jinja")

    rendered = t.render(versions)
    with open(join("output", template), mode="w", encoding="utf-8") as f:
        f.write(rendered)