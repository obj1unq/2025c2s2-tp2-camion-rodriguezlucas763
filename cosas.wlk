import camion.*

object knightRider {
	var property estaEmbalado = false

	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
	method tienePesoPar() {
		return self.peso() % 2 == 0
	}
	method bultos() {
	  return 1
	}
	method seAccidento() {
	  
	}
}
object arenaAGranel {
	var property estaEmbalado = false
	var property peso = 0 

	method nivelPeligrosidad() { return 10 }
	method tienePesoPar() {
		return peso % 2 == 0
	}
	method bultos() {
	  return 1
	}
	method seAccidento() {
	  peso += 20
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
	method bultos() {
	  return 2
	}
	method seAccidento() {
	  if (modoRobot) {
		modoRobot = false
	  }
	  else modoRobot = true
	}
}
object paqueteDeLadrillos {
	var property estaEmbalado = false
	var property cantidad = 0

	method peso() {
		return cantidad * 2
	}
	method nivelPeligrosidad() { return 2 }
	method tienePesoPar() {
		return self.peso() % 2 == 0
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
	var property estaEmbalado = false
	var property peso = 0
	method nivelPeligrosidad() { return 200 }
	method tienePesoPar() {
		return self.peso() % 2 == 0
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
	var property estaEmbalado = false
	
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
		|| almacen.cosas().contains(unaCosa)
		|| (unaCosa.estaEmbalado() && almacen.cosas().contains(embalajeDeSeguridad))
		|| (unaCosa.estaEmbalado() && cosas.contains(embalajeDeSeguridad))
		|| (unaCosa.estaEmbalado() && camion.cosas().contains(embalajeDeSeguridad))
		) {
			self.error(unaCosa + "ya está en el contenedor, en el camion, o en el almacen.")
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
	var property estaEmbalado = false

	method envolver(unaCosa) {
	  unaCosa.estaEmbalado(true)
	  peso = unaCosa.peso()
	  nivelPeligrosidad = unaCosa.nivelPeligrosidad() * 0.5
	}
	method bultos() {
	  return 2
	}
	method seAccidento() {
	  
	}
}