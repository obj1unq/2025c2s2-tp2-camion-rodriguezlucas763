import camion.*

object knightRider {
	var property estaEmbalado = false

	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
	method tienePesoPar() {
		return self.peso() % 2 == 0
	}
}
object arenaAGranel {
	var property estaEmbalado = false
	var property peso = 0 

	method nivelPeligrosidad() { return 10 }
	method tienePesoPar() {
		return peso % 2 == 0
	}
}
object bumblebee {
	var property estaEmbalado = false
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
	var property estaEmbalado = false
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
	var property estaEmbalado = false
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
	var property estaEmbalado = false
	var property peso = 0
	method nivelPeligrosidad() { return 200 }
	method tienePesoPar() {
		return self.peso() % 2 == 0
	}
}
object contenedorPortuario {
	const property cosas = #{}
	
	method peso() {
		return 100 + cosas.sum({cadaCosa => cadaCosa.peso()})
	}
	method nivelPeligrosidad() {
		if (cosas.isEmpty()) {
			return 0
		}
		else {
			return cosas.max({laCosaConMas => laCosaConMas.nivelPeligrosidad()}).nivelPeligrosidad()
		}	
	}
    method primerValidarCargar(unaCosa) {
		if (cosas.contains(unaCosa) 
		|| camion.cosas().contains(unaCosa) 
		|| (unaCosa.estaEmbalado() && cosas.contains(embalajeDeSeguridad))
		|| (unaCosa.estaEmbalado() && camion.cosas().contains(embalajeDeSeguridad))
		) {
			self.error(unaCosa + "ya está en el contenedor o en el camion.")
		}
	}
    method cargar(unaCosa) {
		self.primerValidarCargar(unaCosa)
		if (unaCosa.estaEmbalado()) {
			cosas.add(embalajeDeSeguridad)
		}
		else {
			cosas.add(unaCosa)
		}		
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
}
object embalajeDeSeguridad {
	var property peso = 0
	var property nivelPeligrosidad = 0

	method envolver(unaCosa) {
	  peso = unaCosa.peso()
	  nivelPeligrosidad = unaCosa.nivelPeligrosidad() * 0.5
	}
}