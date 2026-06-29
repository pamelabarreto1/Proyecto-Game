
object bombero {
    var property image = "bomberoPersonaje.png"
    var property position = game.at(1,0)

    var energia = 100
    var property estaCargandoUnCivil = false


    method energia() = energia

    method cansarse() {
        energia = (energia - 1).max(0)
        if (self.energia() == 0) {
            game.schedule(2000, { game.stop() })
        }
    }
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
        }
        estaCargandoUnCivil = true
        image = "bomberoRescate.png"
        game.removeVisual(civil)
    }
    method dejarCivilEnSalida() {
        estaCargandoUnCivil = false
        image = "bomberoPersonaje.png"
    }

    // apagar
    // cargarAgua
}
object energiaBombero {
    const property position = game.at(0, 6)
    method text() = bombero.energia().toString()
    method textColor() = "FF0000FF"
}

object salida {
    const property position = game.at(0, 0)
    const property image = "salida.png"

    method interactuarCon(bombero) {
        if (bombero.estaCargandoUnCivil()) {
            bombero.dejarCivilEnSalida()
            game.say(bombero, "Un civil menos")
        }
    }
}