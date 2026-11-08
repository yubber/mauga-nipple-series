let result = `${CamPos} + ${dist} * (
	${x} * crossProduct(directionTowards(${CamPos}, ${LookPos}), angleToDirection(horizontalAngleOfDirection(directionTowards(${CamPos}, ${LookPos})), verticalAngleOfDirection(directionTowards(${CamPos}, ${LookPos})) - 90)) +
	(${y} - 0.200) * angleToDirection(horizontalAngleOfDirection(directionTowards(${CamPos}, ${LookPos})), verticalAngleOfDirection(directionTowards(${CamPos}, ${LookPos})) - 90) +
	3 * directionTowards(${CamPos}, ${LookPos}))
`

result