class Raza {
  var property fuerza
  var property inteligencia
  var property rol
  
  method fuerza() = fuerza
  
  method inteligencia() = inteligencia
  
  method potencialOfensivo() = (fuerza * 10) + rol.potencialExtra()
  
  method esGroso() = self.esInteligente() || self.esGrosoEnSuRol()
  
  method esInteligente()
  
  method esGrosoEnSuRol() = rol.esGroso(self)
}

class Orco inherits Raza {
  override method potencialOfensivo() = if (rol == brujo) {
    (fuerza * 10) * 1.1
  } else {
    super()
  }
  
  override method esInteligente() = false
}

class Humano inherits Raza {
  override method esInteligente() = inteligencia > 50
}

object guerrero {
  method potencialExtra() = 100
  
  method esGroso(unPersonaje) = unPersonaje.fuerza()
}

class Cazador {
  var property mascota
  
  method potencialExtra() = mascota.potencialOfensivo()
  
  method esGroso(unPersonaje) = mascota.edad() > 10
}

object brujo {
  method potencialExtra() = 0
  
  method esGroso() = true
}

class Animal {
  const fuerza
  var edad
  var tieneGarras
  
  method potencialOfensivo() = if (tieneGarras) fuerza * 2 else fuerza
  
  method cortaGarras() {
    tieneGarras = false
  }
  
  method crecerGarras() {
    tieneGarras = true
  }
  
  method fuerza() = fuerza
  
  method edad() = edad
  
  method cumplirAnios() {
    edad += 1
  }
}

class Localidades {
  var property ejercito
  
  method potencialDefensivo() = ejercito.potencialTotal()
  
  method serOcupada(unEjercito)
}

class Aldeas inherits Localidades {
  const property cantMaximaHabitantes
  
  override method serOcupada(unEjercito) {
    if (unEjercito.size() > cantMaximaHabitantes) {
      ejercito = unEjercito.nuevoEjercitoFuerte(10)
    }
  }
}

class Ciudades inherits Localidades {
  override method potencialDefensivo() = super() + 300
  
  override method serOcupada(unEjercito) {
    ejercito = unEjercito
  }
}

class Ejercito {
  const property personajes = []
  
  method potencialTotal() = personajes.sum({ p => p.poderOfensivo() })
  
  method puedeTomarLocalidad(
    unaLocalidad
  ) = self.potencialTotal() > unaLocalidad.potenciaDefensivo()
  
  method invadir(unaLocalidad) {
    if (self.puedeTomarLocalidad(unaLocalidad)) unaLocalidad.serOcupada(self)
  }
  
  method nuevoEjercitoFuerte(unaCantidad) {
    const nuevoEjercito = personajes.sortBy(
      { p1, p2 => p1.poderOfensivo() > p2.poderOfensivo() }
    ).take(unaCantidad)
    personajes.removeAll(nuevoEjercito)
    return new Ejercito(personajes = nuevoEjercito)
  }
}

const orco1 = new Orco(fuerza = 10, inteligencia = 2, rol = brujo)
