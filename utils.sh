function mirror() {
	
	local directory="$(mktemp --directory)"
	local source="${1}"
	local destination="${2}"
	
	local secret="${3}"
	
	local url="https://github:${secret}@github.com/${destination}"
	
	git clone --quiet --mirror "${source}" "${directory}"
	
	git -C "${directory}" push --force --quiet --branches "${url}"
	git -C "${directory}" push --force --quiet --tags "${url}"
	
	git config --global user.email "41898282+github-actions[bot]@users.noreply.github.com"
	git config --global user.name "github-actions[bot]"
	
	git branch timestamp
	git checkout timestamp
	
	date > timestamp
	git add timestamp
	git commit -m "Initial commit"
	
	git push --force --quiet origin timestamp
	
}
	