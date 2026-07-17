import escenarios.*
import civiles_y_fuego.*
import logros.*

object bombero {
    var property position = game.at(1,0)
    var agua = 0
    var energia = 100
    var property estaCargandoUnCivil = false 

    method image() = if (estaCargandoUnCivil) "bomberoRescate.png" else "bomberoPersonaje.png"

    method energia() = energia
    method agua() = agua

    method prepararNivel(nuevaPosicion, nuevaEnergia, cantAgua) {
        position = nuevaPosicion
        energia = nuevaEnergia
        agua = cantAgua
        estaCargandoUnCivil = false
    }

    method seQuedoSinEnergia() {
        return energia == 0
    }

    method fallarSiSeAgoto() {
        if (self.seQuedoSinEnergia()) {
            administradorDeNivel.perderJuego() 
        }
    }
 
    method cansarse() { 
        energia = (energia - 1).max(0)
        self.fallarSiSeAgoto()
    }

    method quemarse(cantidad) {
        energia = (energia - cantidad).max(0)
        self.fallarSiSeAgoto()  
    }

    method puedeIrA(nuevaPosicion) {
        const objetosEnPosicion = game.getObjectsIn(nuevaPosicion)
        return objetosEnPosicion.all({ o => o.esAtravesable() })
    }

    method moverseHacia(nuevaPosicion) {
        if (self.puedeIrA(nuevaPosicion) and not (self.estaEnMinijuego())) {
            position = nuevaPosicion
            self.cansarse()
        }
    }

    method subir() {
        self.moverseHacia(position.up(1))
    }

    method bajar() {
        self.moverseHacia(position.down(1))
    }

    method derecha() {
        self.moverseHacia(position.right(1))
    }

    method izquierda() {
        self.moverseHacia(position.left(1))
    }

    method rescatar(civil) {
        if (estaCargandoUnCivil) {
            game.say(self, "Antes tengo que dejar al civil en un lugar seguro")
        } else {
            estaCargandoUnCivil = true
            game.removeVisual(civil)
        }
    }
    
    method dejarCivilEnSalida() {
        estaCargandoUnCivil = false
    }
         
   method apagar(fuego) {
        if (game.hasVisual(fuego)) {
            game.removeVisual(fuego)
            agua = (agua - 1).max(0)
            self.cansarse()

            return true 
        }
        return false 
    }

    method cargarAgua() {
        agua = 5 
        game.say(self, "¡Manguera cargada!")
    }
    var estaEnMinijuego = false
    method estaEnMinijuego() = estaEnMinijuego
    method ahoraEstaEnMinjuego(unBool) {
        estaEnMinijuego = unBool
    }
}

object energiaBombero {
    var property position = game.at(1, 14)
    
    method text() = "Energía Restante: " + bombero.energia().toString()
    method textColor() = "FFFFFFFF"
    method interactuarCon(unBombero) {}
    method esAtravesable() = true
}

object cantidadDeAguaBombero {
    var property position = game.at(1, 13)
    
    method text() = "Agua Restante: " + bombero.agua().toString()
    method textColor() = "FFFFFFFF"
    method interactuarCon(unBombero) {}
    method esAtravesable() = true
}
