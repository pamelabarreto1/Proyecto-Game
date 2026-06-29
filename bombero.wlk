
object bombero {
    var property image = "bomberoPersonaje.png"

    var property position = game.origin()
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
            self.error(game.say(self, "Antes tengo que dejar al civil en un lugar seguro"))
        }
        estaCargandoUnCivil = true
        image = "BomberoRescate.png"
        game.removeVisual(civil)
    }
    method dejarCivilEnSalida() {
        estaCargandoUnCivil = false
        image = "bomberoPersonaje.png"
    }
    // apagar
    // cargarAgua
}