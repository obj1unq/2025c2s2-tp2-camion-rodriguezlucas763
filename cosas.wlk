object knightRider {
  method peso() { return 500 }
  method nivelPeligrosidad() { return 10 }
  method tienePesoPar() {
	return self.peso() % 2 == 0
  }
}
object arenaAGranel {
  var property peso = 0 

  method nivelPeligrosidad() { return 10 }
  method tienePesoPar() {
	return peso % 2 == 0
  }
}
object bumblebee {
  var property modoRobot = false

  method peso() { return 800 }
  method nivelPeligrosidad() { 
	if (modoRobot) {
		return 30
	}
	else return 15
  }
  method tienePesoPar() {
	return self.peso() % 2 == 0
  }
}
object paqueteDeLadrillos {
  var cantidad = 0

  method cantidad(numero) {
	cantidad = numero
  } 
  method peso() {
	return cantidad * 2
  }
  method nivelPeligrosidad() { return 2 }
  method tienePesoPar() {
	return self.peso() % 2 == 0
  }
}
object bateriaAntiaerea {
  var property tieneMisiles = false

  method peso() {
	if (tieneMisiles) {
		return 300
	}
	else return 200
  }
  method nivelPeligrosidad() {
	if (tieneMisiles) {
		return 100
	}
	else return 0
  }
  method tienePesoPar() {
	return self.peso() % 2 == 0
  }
}
object residuosRadioactivos {
  var property peso = 0
  method nivelPeligrosidad() { return 200 }
  method tienePesoPar() {
	return self.peso() % 2 == 0
  }
}



