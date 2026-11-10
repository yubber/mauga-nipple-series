// tx codes, escaped " and translated strings are automatically handled.
// no need to double wrap tx codes in \"

// vars, wrapTranslate, arr

let outpoot = ""

vars.forEach((v, i) => {
    // console.log("Var", v, i)
	outpoot += `globalvar ${v} = [` + arr.map( e => {
		let sanitized = e[i].toString()
			.replaceAll(/"/g, '\\"') // preserve literal "
			.replace(/<tx[0-9A-Fa-f]+>/g, `'$&'`) // add quote to TX
			.replaceAll(/\n/g, '\\n') // newlines
		return wrapTranslate[i] ? `___(\"${sanitized}\")` : sanitized
	}) + "]\n"
})

// console.log(outpoot)
outpoot