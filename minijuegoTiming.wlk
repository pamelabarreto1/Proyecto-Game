import bombero.*
import civiles_y_fuego.*
import escenarios.*


class BarraTiming {

    const property position = game.at(7, 15)
    const property image = "barraTiming.png" 
}

class CursorTiming {
    var property position = game.at(7, 14)
    var direccion = 1
    
    const property image = "cursorTiming.png"

    method mover() {
        if (position.x() >= 11) {
            direccion = -1
        } 
        if (position.x() <= 7) {
            direccion = 1
        }
        position = position.right(direccion)
    }

    method resetear() {
        position = game.at(7, 14)
        direccion = 1
    }

    method estaEnZonaDeExito() {
        return position.x() == 9
    }
}
object minijuegoTiming {
    var fuegoObjetivo = null
    var juegoTerminado = false 

    const barra = new BarraTiming()
    const cursor = new CursorTiming()

    method iniciar(fuego) {
        fuegoObjetivo = fuego

        juegoTerminado = false 
        cursor.resetear()

        
        game.addVisual(barra)
        game.addVisual(cursor)

        game.onTick(200, "movimientoDelCursor", { cursor.mover() })
        keyboard.space().onPressDo({ self.verificarSiSeApagaElFuego() })
    }

    method verificarSiSeApagaElFuego() {
        if (not juegoTerminado) {
            juegoTerminado = true
            game.removeTickEvent("movimientoDelCursor")
            keyboard.space().onPressDo({})

            if (cursor.estaEnZonaDeExito()) {
                self.ganar()
            } else {
                self.perder()
            }
            self.finalizar()
        }
    }

    method ganar() {
        
        const seApagoRealmente = bombero.apagar(fuegoObjetivo) 
        if (seApagoRealmente) {
            administradorDeNivel.cumplirObjetivo()
        }
    }
 
    method perder() {
        game.say(bombero, "¡Uff! No logré apagar el fuego.")
        bombero.quemarse(fuegoObjetivo.daño())
        fuegoObjetivo.estaSiendoApagado(false)
    }

    method finalizar() {

        game.removeVisual(barra)
        game.removeVisual(cursor)

        keyboard.space().onPressDo({})

    }
}