import cosas.*
object camion {
	const cosas = #{}
	const tara = 1000
	const pesoMaximo = 2500
	
	method cosas() {
	  return cosas
	}
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
		if (cosas.contains(unaCosa)) {
			self.error(unaCosa + "ya está en el camion.")
		}
	}
    method cargar(unaCosa) {
		self.validarCargar(unaCosa)
		cosas.add(unaCosa)		
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
	method elDeNivel(nivel) {
	  return cosas.find({cosa => cosa.nivelPeligrosidad() == nivel})
	}
	method cosasPeligrosasMayoresA(nivel) {
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
	method validarTransportar(destino, camino) {
	  if (not camino.puedeSoportarElViaje()) {
		self.error("El camion no puede soportar el viaje")
	  }
	}
	method transportar(destino, camino) {
	  self.validarTransportar(destino, camino)
	  cosas.forEach({cadaCosa => self.descargar(cadaCosa)  // o bien cosas.clear(), pero ya que está podría usar descargar() jaja
	  			   ; almacen.cargar(cadaCosa)}) 
	}
}

object ruta9 {
  var property peligrosidadMaxima = 0

  method puedeSoportarElViaje() {
	return camion.puedeCircularEn(self)
  }
}
object caminoVecinal {
  var property pesoMaximo = 0

  method puedeSoportarElViaje() {
	return camion.peso() <= pesoMaximo
  }
}
object almacen {
  const property cosas = #{}

  method cargar(unaCosa) {
	cosas.add(unaCosa)
  }
}