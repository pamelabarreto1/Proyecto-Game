
object bombero {
    var property image = "bomberoPersonaje.png"
    var property position = game.at(1,0)

    var property energia = 100
    var property estaCargandoUnCivil = false


    method energia() = energia

    method subir() {
        position = position.up(1)
        energia = (energia - 1).max(0)
    }
    method bajar() {
        position = position.down(1)
        energia = (energia - 1).max(0)
    }
    method derecha() {
        position = position.right(1)
        energia = (energia - 1).max(0)
    }
    method izquierda() {
        position = position.left(1)
        energia = (energia - 1).max(0)
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
    const property position = game.at(5, 5)
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