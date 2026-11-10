// strin, n, literals, replaceI
let out = literals
let processed;

for (let i = 0; i < n; i++) {
	processed = `"${strin.replaceAll(/"/g, '\\"')}"` // preserve literal ", encase string
	if (replaceI !== null) {
		out += processed.replaceAll(replaceI, i.toString())
	} else {
		out += processed
	}
	out += " "
}

out