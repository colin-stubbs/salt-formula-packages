{% from "packages/map.jinja" import packages_map with context %}

{# install packages #}
{% for name, options in packages_map.get('install', {}).items() %}
packages-install-{{ name }}:
{% if options != None %}
  pkg.installed:
{% if options.name %}
    - name: {{ options.name }}
{% else %}
    - name: {{ name }}
{% endif %}
{% if options.version %}
    - version: {{ options.version }}
{% endif %}
{% for option_name, option_value in options.get('options', {}).items() %}
    - {{ option_name }}: {{ option_value }}
{% endfor %}
{% endif %}
{% endfor %}
{% else %}
  pkg.installed: []
{% endif %}

{# uninstall packages #}
{% for name in packages_map.get('uninstall', []) %}
packages-uninstall-{{ name }}:
  pkg.removed:
    - name: {{ name }}
{% endfor %}
