import civiles_y_fuego.*


object bombero {
    var property image = "bomberoPersonaje.png"
    var property position = game.at(1,0)
    var agua=0
    var energia = 100
    var property estaCargandoUnCivil = false 

    
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
        }
        estaCargandoUnCivil = true
        image = "bomberoRescate.png"
        game.removeVisual(civil)
    }
    method dejarCivilEnSalida() {
        estaCargandoUnCivil = false
        image = "bomberoPersonaje.png"
    }

    method apagar(fuego){
    
        agua= agua-1
        self.cansarse()
        game.removeVisual(fuego)
        game.say(self, "Fuego apagado!")
    
    }
    method cargarAgua(){
        agua=3
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
        }
    }
}