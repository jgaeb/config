let b:ale_linters = ['flake8', 'pylint', 'mypy']
let b:ale_fixers = ['black', 'isort']
let g:ale_python_flake8_options = '--max-line-length=88'
let g:ale_virtualenv_dir_names = ['venv', '.venv', 'virtualenv', '.virtualenv']
