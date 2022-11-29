#!/bin/bash
# formats both terragrunt files and terraform .tf files
DEBUG=0

format_hcl() {
  cat "$1" | terraform fmt - > "$1.tmp"
  if (diff "$1" "$1".tmp > /dev/null); then
    rm -f "$1.tmp"
  else
    mv -f "$1.tmp" "$1"
    echo "$1"
  fi
}

format_dir() {
  dirs=$(find "$1" -type f -name '*.tf*' | grep -v '/.terra' | sed -r 's|/[^/]+$||' |sort |uniq)
  for dir in $dirs; do
    [[ $DEBUG -eq 1 ]] && echo "# terraform fmt $dir" >&2
    terraform fmt "${dir}/"
  done

  hcls=$(find "$1" -type f -name '*.hcl' | grep -v '/.terra')
  for hcl in $hcls; do
    [[ $DEBUG -eq 1 ]] && echo "# format_hcl $hcl" >&2
    format_hcl "$hcl"
  done
}

format_file() {
  if [[ "$1" =~ \.tf$ || "$1" =~ \.tfvars$ ]]; then
    [[ $DEBUG -eq 1 ]] && echo "# terraform fmt $1" >&2
    terraform fmt "$1"
  elif [[ "$1" =~ \.hcl$ ]]; then
    [[ $DEBUG -eq 1 ]] && echo "# format_hcl $1" >&2
    format_hcl "$1"
  fi
}

format_file_or_dir() {
  if [[ -d "$1" ]]; then
    format_dir "$1"
  elif [[ -e "$1" ]]; then
    format_file "$1"
  fi
}

format_all() {
  for file_or_dir in "$@"; do
    format_file_or_dir "${file_or_dir}"
  done
}

main() {
  if [[ -z $1 ]]; then
    echo "Usage: $0 <file/dir1> .. <file/dirN>" >&2
    exit 1
  fi
  format_all "$@" | tr -s "[:space:]" | tr -s "[:space:]" "\n" | sort -u
}

main "$@"
