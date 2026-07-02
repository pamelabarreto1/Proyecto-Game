import escenarios.*
import civiles_y_fuego.*




object bombero {
    var property image = "bomberoPersonaje.png"
    var property position = game.at(1,0)
    var agua = 3
    var energia = 100
    var property estaCargandoUnCivil = false 
    var civilCargado = null

    
    method energia() = energia
    method agua() = agua
    
    method cansarse() { // cada que movemos se cansa la energia baja en 1
        energia = (energia - 1).max(0)
        if (self.energia() == 0) {
            game.schedule(0, { game.stop() })
        }
    }

// tocar el fuego baja "cantidad" de energia. Lo decide la clase Fuego (aca podemos hacer que varie el "daño" dependiendo la dificultad)

    method quemarse(cantidad) {
        energia = (energia - cantidad).max(0)
        if (self.energia() == 0) {
            game.schedule(0, { game.stop() })
        }
    }

    method subir() {
        position = position.up(1)
        self.cansarse()
    }
    method bajar() {
        position = position.down(1)
        self.cansarse()
    }
    method derecha() {
        position = position.right(1)
        self.cansarse()
    }
    method izquierda() {
        position = position.left(1)
        self.cansarse()
    }

    method rescatar(civil) {
        if (estaCargandoUnCivil) {
            game.say(self, "Antes tengo que dejar al civil en un lugar seguro")
        } else {
            estaCargandoUnCivil = true
            civilCargado = civil
            image = "bomberoRescate.png"
            game.removeVisual(civil)
        }
    }
    method dejarCivilEnSalida() {
        estaCargandoUnCivil = false
        civilCargado.serSalvado()
        civilCargado = null
        image = "bomberoPersonaje.png"
    }

     method apagarALaDerecha() {
        const celdaALaDerecha = self.position().right(1)
        const objetosEnCelda = celdaALaDerecha.getObjectsIn()
        
        if (objetosEnCelda.any({obj => obj.className() == "Fuego"}) && agua >= 1) {
            objetosEnCelda.filter({obj => obj.className() == "Fuego"}).forEach({f => f.serApagado()})
            agua = agua - 25
        }
    }

    method apagarALaIzquierda() {
        const celdaALaIzquierda = self.position().left(1)
        const objetosEnCelda = game.getObjectsIn(celdaALaIzquierda)

        if (objetosEnCelda.any({obj => obj.className() == "Fuego"}) && agua >= 1) {
            objetosEnCelda.filter({obj => obj.className() == "Fuego"}).forEach({f => f.serApagado()})
        }
    }

    method apagarAbajo() {
        const celdaAbajo = self.position().down(1)
        const objetosEnCelda = game.getObjectsIn(celdaAbajo)

        if (objetosEnCelda.any({obj => obj.className() == "Fuego"}) && agua >= 1) {
            objetosEnCelda.filter({obj => obj.className() == "Fuego"}).forEach({f => f.serApagado()})
        }
    }

    method apagarArriba() {
        const celdaArriba = self.position().up(1)
        const objetosEnCelda = game.getObjectsIn(celdaArriba)

        if (objetosEnCelda.any({obj => obj.className() == "Fuego"}) && agua >= 1) {
            objetosEnCelda.filter({obj => obj.className() == "Fuego"}).forEach({f => f.serApagado()})
        }
    }

    method cargarAgua(){
        agua=3 //le puse como limite 3 pero podemos configurarlo a mas
        game.say(self, "Manguera cargada!")
    }
   


}

// cartel para visualizar la energia del personaje
object energiaBombero {
    const property position = game.at(0, 6)
    method text() = bombero.energia().toString()
    method textColor() = "FF0000FF"
}
// objeto agregado para que el bombero "deje" al civil y vuelva a su estado base
object salida {
    const property position = game.at(0, 0)
    const property image = "salida.png"

    method interactuarCon(bombero) {
        if (bombero.estaCargandoUnCivil()) {
            bombero.dejarCivilEnSalida()
            game.say(bombero, "Un civil menos")
            administradorDeNivel1.cumplirObjetivo()
        }
    }
}