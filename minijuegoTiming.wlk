import bombero.*
import civiles_y_fuego.*

object barraTiming {
    method position() = game.at(7, 15)
    method image() = "barraTiming.png" 
}

object cursorTiming {
    var property position = game.at(7, 14)
    var direccion = 1
    
    method image() = "cursorTiming.png"

    method mover() {
        
        if (position.x() >= 11) {
            direccion = -1
        } 
        if (position.x() <= 7) {
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

        game.onTick(200, "movimientoDelCursor", {cursorTiming.mover()})

        keyboard.space().onPressDo({self.verificarSiSeApagaElfuego()})

    }

    method verificarSiSeApagaElfuego() {
        game.removeTickEvent("movimientoDelCursor")

        if (cursorTiming.position().x() == 9) {
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
        bombero.quemarse(fuegoObjetivo.daño())
    }

    method finalizar() {
        game.removeVisual(barraTiming)
        game.removeVisual(cursorTiming)
        
        keyboard.space().onPressDo({})
    }
}