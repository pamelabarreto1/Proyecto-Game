import bombero.*
import civiles_y_fuego.*
import escenarios.*


class BarraTiming {
    const property position = game.at(7, 15)
    
    const property limiteIzquierdo = 7
    const property limiteDerecho = 11
    const property zonaExito = 9
    const property image = "barraTiming.png" 
}

class CursorTiming {
    const barraBase 
    var property position = game.at(0,0) 
    var direccion = 1
    
    const property image = "cursorTiming.png"

    method mover() {
        
        if (position.x() >= barraBase.limiteDerecho()){
            direccion = -1
        }
        if (position.x() <= barraBase.limiteIzquierdo()) {
            direccion = 1
        }
        position = position.right(direccion)
    }

    method resetear() {
        
        position = game.at(barraBase.limiteIzquierdo(), barraBase.position().y() - 1)
        direccion = 1
    }

    method estaEnZonaDeExito() {
        return position.x() == barraBase.zonaExito()
    }
}

object minijuegoTiming {
    var fuegoObjetivo = null
    var bomberoJugando = null 
    var juegoTerminado = false 

    const barra = new BarraTiming()
    const cursor = new CursorTiming(barraBase = barra) 

    method iniciar(fuego, bombero) {
        fuegoObjetivo = fuego
        bomberoJugando = bombero
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
            
    
            const fueExitoso = cursor.estaEnZonaDeExito()
            fuegoObjetivo.resolverApagado(fueExitoso, bomberoJugando)
            
            self.finalizar()
        }
    }

    method finalizar() {
        game.removeVisual(barra)
        game.removeVisual(cursor)
        keyboard.space().onPressDo({}) 
    }
}