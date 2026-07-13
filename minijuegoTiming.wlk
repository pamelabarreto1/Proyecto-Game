import bombero.*
import civiles_y_fuego.*

object barraTiming {
    method position() = game.at(5, 8)
    method image() = ""
}

object cursorTiming {
    var property position = game.at(5, 8)
    var direccion = 1
    
    method image() = ""

    method mover() {
        // Mueve el cursor desde 5,8 hasta 9,8 y viceversa
        if (position.x() >= 9) {
            direccion = -1
        } 
        if (position.x() <= 5) {
            direccion = 1
        }

        position = position.right(direccion)
    }
}

object minijuegoTiming {
    var fuegoObjetivo = null

    method iniciar(fuego) {
        fuegoObjetivo = fuego
        
        game.addVisual(barraTiming)
        game.addVisual(cursorTiming)

        game.onTick(1000, "movimientoDelCursor", {cursorTiming.mover()})

        keyboard.space().onPressDo({self.verificarSiSeApagaElfuego()})

    }

    method verificarSiSeApagaElfuego() {
        game.removeTickEvent("movimientoDelCursor")

        if (cursorTiming.position().x() == 7) {
            self.ganar()
        } else {
            self.perder()
        }
        self.finalizar()
    }

    method ganar() {
        game.say(bombero, "Bien! Fuego apagado!")
        bombero.apagar(fuegoObjetivo)
    }

    method perder() {
        game.say(bombero, "Uff! No logre apagar el fuego!")
    }

    method finalizar() {
        
    }
}