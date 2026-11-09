// tx codes, escaped " and translated strings are automatically handled.
// no need to double wrap tx codes in \"

// vars, wrapTranslate, arr

let output = ""

vars.forEach((v, i) => {
    // console.log("Var", v, i)
	output += `globalvar ${v} = [` + arr.map( e => {
		let sanitized = e[i].toString()
			.replace(/"/g, '\\"') // preserve literal "
			.replace(/<tx[0-9A-Fa-f]+>/g, `'$&'`) // add quote to TX
			.replace(/\n/g, '\\n') // newlines
		return wrapTranslate[i] ? `___(\"${sanitized}\")` : sanitized
	}) + "]\n"
})

// console.log(output)
output