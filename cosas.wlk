import camion.*

object knightRider {
	var property estaEmbalado = false

	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
	method tienePesoPar() {
		return self.peso().even()
	}
	method bultos() {
	  return 1
	}
	method seAccidento() {
	  
	}
}
object arenaAGranel {
	var property peso = 0 

	method nivelPeligrosidad() { return 10 }
	method tienePesoPar() {
		return peso.even()
	}
	method bultos() {
	  return 1
	}
	method seAccidento() {
	  peso += 20
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
		return self.peso().even()
	}
	method bultos() {
	  return 2
	}
	method seAccidento() {
	  modoRobot = not modoRobot
	}
}
object paqueteDeLadrillos {
	var property cantidad = 0

	method peso() {
		return cantidad * 2
	}
	method nivelPeligrosidad() { return 2 }
	method tienePesoPar() {
		return self.peso().even()
	}
	method bultos() {
	  if (cantidad <= 100) {
		return 1
	  }
	  else if (cantidad >= 101 && cantidad <= 300) {
		return 2
	  }
	  else return 3
	}
	method seAccidento() {
	  if (cantidad >= 12) {
		cantidad -= 12
	  }
	  else cantidad = 0 
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
		return self.peso().even()
	}
	method bultos() {
	  if (tieneMisiles) {
		return 2
	  }
	  else return 1
	}
	method seAccidento() {
	  tieneMisiles = false 
	}
}
object residuosRadioactivos {
	var property peso = 0
	method nivelPeligrosidad() { return 200 }
	method tienePesoPar() {
		return self.peso().even()
	}
	method bultos() {
	  return 1
	}
	method seAccidento() {
	  peso += 15 
	}
}
object contenedorPortuario {
	const property cosas = #{}
	const pesoDelContenedor = 100
	
	method pesoDeLaCarga() {
	  return cosas.sum({cadaCosa => cadaCosa.peso()})
	}
	method peso() {
		return pesoDelContenedor + self.pesoDeLaCarga()
	}
	method nivelPeligrosidad() {
		if (cosas.isEmpty()) {
			return 0
		}
		else {
			return cosas.max({laCosaConMas => laCosaConMas.nivelPeligrosidad()}).nivelPeligrosidad()
		}	
	}
    method validarCargar(unaCosa) {
		if (cosas.contains(unaCosa)) {
			self.error(unaCosa + "ya está en el contenedor.")
		}
	}
    method cargar(unaCosa) {
		self.validarCargar(unaCosa)
		cosas.add(unaCosa)	
	}
	method validarDescargar(unaCosa) {
		if (not cosas.contains(unaCosa)) {
		self.error("El contenedor no tiene" + unaCosa)
		}
	}
	method descargar(unaCosa) {
		self.validarDescargar(unaCosa)
		cosas.remove(unaCosa)
	}
	method bultos() {
	  return 1 + cosas.sum({cadaCosa => cadaCosa.bultos()})
	}
	method seAccidento() {
	  cosas.forEach({cadaCosa => cadaCosa.seAccidento()}) 
	}
}
object embalajeDeSeguridad {
	var property peso = 0
	var property nivelPeligrosidad = 0
	var objetoEmbalado = ""

	method envolver(unaCosa) {
	  objetoEmbalado = unaCosa
	  peso = unaCosa.peso()
	  nivelPeligrosidad = unaCosa.nivelPeligrosidad() * 0.5
	}
	method bultos() {
	  return 2
	}
	method seAccidento() {
	  
	}
}