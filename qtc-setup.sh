#!/bin/sh
set -e -x

# Setup workspace for qt-creator
# Creates "project" config files

die() {
  echo "$1"
  exit 1
}

# Find all directories containing headers
findinc() {
  git ls-files|grep '\.h$'| xargs -l1 dirname|sort -u
}

[ -f ./RELEASE.local ] || die "Execute from the wrapper repo top"

ROOT="$PWD"

for repo in epics-base pvData pvAccess pvaSrv
do
  [ -d "$repo" ] || continue

  cat << EOF > "$repo/$repo.creator"
[General]
EOF

  cat <<EOF > "$repo/$repo.config"
EOF

  (cd "$repo" && git ls-files) > "$repo/$repo.files"

  # first pass for .includes
  (cd "$repo" && findinc) > "$repo/$repo.includes"

  if ! grep "^$repo\.\*$" ".git/modules/$repo/info/exclude"
  then
    cat << EOF >> ".git/modules/$repo/info/exclude"
$repo.*

EOF

    cat "$repo/$repo.includes" >> ".git/modules/$repo/info/exclude"
  fi
done

# special handling for *.includes
# not so simple for pv* as most headers are included as "pv/*.h"
# but don't appear in a pv/ sub-dir in the source tree :(

for repo in pvData pvAccess
do
  for dir in `cat "$repo/$repo.includes"`
  do
    # don't overwrite if exists and not a symlink
    [ -e "$repo/$dir/pv" -a ! -h "$repo/$dir/pv" ] && continue

    # An ugly hack, in each directory containing headers,
    # create a symlink 'pv' pointing to '.'.  So './pv/foo' points to './foo'
    rm -f "$repo/$dir/pv"
    ln -s . "$repo/$dir/pv"

    cat << EOF >> "$repo/$repo.includes"
$dir/pv
EOF
  done
done

# merge .includes for dependent packages

mergeme() {
   output="$1"
   shift
   echo "Module $output depends on $@"

   for repo in "$@"
   do
       cat "$repo/$repo.includes" \
       | while read dir; do if expr match "$dir" "^/" >/dev/null; \
          then echo "$dir"; \
          else echo "$ROOT/$repo/$dir"; fi; done \
       >> "$output/$output.includes"
   done
}

mergeme pvData epics-base
mergeme pvAccess pvData epics-base
mergeme pvaSrv pvAccess pvData epics-base