import cosas.*
object camion {
	const property cosas = #{}
	const tara = 1000
	const pesoMaximo = 2500
	
	method peligrosidad() {
	  return cosas.sum({cadaCosa => cadaCosa.nivelPeligrosidad()})
	}
	method peso() {
	  return tara + self.pesoDeLaCarga()
	}
	method pesoDeLaCarga() {
	  return cosas.sum({cadaCosa => cadaCosa.peso()})
	}
	method estaExcedidoDePeso() {
	  return self.peso() > pesoMaximo
	}
    method validarCargar(unaCosa) {
		if (cosas.contains(unaCosa) 
		|| contenedorPortuario.cosas().contains(unaCosa) 
		|| (unaCosa.estaEmbalado() && cosas.contains(embalajeDeSeguridad))
		|| (unaCosa.estaEmbalado() && contenedorPortuario.cosas().contains(embalajeDeSeguridad))
		) {
			self.error(unaCosa + "ya está en el contenedor o en el camion.")
		}
	}
    method cargar(unaCosa) {
		self.validarCargar(unaCosa)
		if (unaCosa.estaEmbalado()) {
			cosas.add(embalajeDeSeguridad)
		}
		else {
			cosas.add(unaCosa)
		}		
	}
	method validarDescargar(unaCosa) {
	  if (not cosas.contains(unaCosa)) {
		self.error("El camión no tiene" + unaCosa)
	  }
	}
	method descargar(unaCosa) {
		self.validarDescargar(unaCosa)
		cosas.remove(unaCosa)
	}
	method todoPesoEsPar() {
	  return cosas.all({cadaCosa => cadaCosa.tienePesoPar()})
	}
	method hayAlgunoQuePesa(peso) {
	  return cosas.any({cadaCosa => cadaCosa.peso() == peso})
	}
	method validarElDeNivel(nivel) {
	  if (not cosas.any({unaCosa => unaCosa.nivelPeligrosidad() == nivel})) {
		self.error("No hay cosas con nivel de peligrosidad: " + nivel)
	  }
	}
	method elDeNivel(nivel) {
	  self.validarElDeNivel(nivel)
	  return cosas.find({cosa => cosa.nivelPeligrosidad() == nivel})
	}
	method validarCosasPeligrosasMayoresA(nivel) {
	  if (not cosas.any({cosa => cosa.nivelPeligrosidad() > nivel})) {
		self.error("No hay cosas mas peligrosas a" + nivel)
	  }
	}
	method cosasPeligrosasMayoresA(nivel) {
	  self.validarCosasPeligrosasMayoresA(nivel)
	  return cosas.filter({cosa => cosa.nivelPeligrosidad() > nivel})
	}
	method validarMasPeligrosasQue(unaCosa) {
	  if (not cosas.any({cosa => cosa.nivelPeligrosidad() > unaCosa.nivelPeligrosidad()})) {
		self.error("Dentro del camion no hay cosas mas peligrosas que: " + unaCosa)
	  }
	}
	method masPeligrosasQue(unaCosa) {
	  self.validarMasPeligrosasQue(unaCosa)
	  return cosas.filter({cosa => cosa.nivelPeligrosidad() > unaCosa.nivelPeligrosidad()})
	}
	method puedeCircularEn(unaRuta) {
	  return self.peso() <= pesoMaximo && self.peligrosidad() <= unaRuta.peligrosidadMaxima()
	}
	method tieneAlgoQuePesaEntre(minimo, maximo) {
	  return cosas.any({unaCosa => unaCosa.peso() >= minimo 
	  							&& unaCosa.peso() <= maximo})	
	}
	method validarLaCosaMasPesada() {
	  if (cosas.isEmpty()) {
		self.error("El camion esta vacio")
	  }
	}
	method laCosaMasPesada() {
	  self.validarLaCosaMasPesada()
	  return cosas.max({unaCosa => unaCosa.peso()})
	}
	method pesos() {
	  return cosas.map({unaCosa => unaCosa.peso()})
	}
	method totalBultos() {
	  return cosas.sum({cadaCosa => cadaCosa.bultos()})
	}
	method sufrirAccidente() {
	  cosas.forEach({cadaCosa => cadaCosa.seAccidento()})
	}
}

object ruta {
  var property peligrosidadMaxima = 0
}