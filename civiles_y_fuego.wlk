import escenarios.*
import minijuegoTiming.*
import logros.*
class Elemento {
    method interactuarCon(bombero)
    method esAtravesable()
}
class Civil inherits Elemento {
    var property position
    const property image
    var estaSiendoRescatado = false

    override method interactuarCon(bombero) {
        if (not estaSiendoRescatado and not bombero.estaCargandoUnCivil()) {
            estaSiendoRescatado = true
            bombero.rescatar(self) 
        }
    }

    override method esAtravesable() = true
}

class Fuego inherits Elemento {
    const property position 
    const property image = "flama.png"
    var property daño = 20
    var property estaSiendoApagado = false 

    override method interactuarCon(bombero) {
        if (not estaSiendoApagado) {
            if (bombero.agua() > 0) {
                
                minijuegoTiming.iniciar(self, bombero) 
                estaSiendoApagado = true 
            } 
            else {
                bombero.quemarse(daño)
                game.say(bombero, "¡Auch, no tengo agua y me quemé!")
            }
        }
    }
    
    method resolverApagado(fueExitoso, bombero) {
        if (fueExitoso) {
            const seApagoRealmente = bombero.apagar(self)
            if (seApagoRealmente) {
                administradorDeNivel.cumplirObjetivo()
                estadisticasDelJuego.sumarIncendioApagado()
            }
        } else {
            game.say(bombero, "¡Uff! No logré apagar el fuego.")
            bombero.quemarse(self.daño())
            estaSiendoApagado = false 
        }
    }

    override method esAtravesable() = true
}

class Lago inherits Elemento {
    const property position 
    const property image = "lago.png" 

    override method interactuarCon(bombero) {
        bombero.cargarAgua() 
    }
    
    override method esAtravesable() = true
}

class MuroInvisible inherits Elemento {
    const property position

    override method interactuarCon(bombero) {}
    override method esAtravesable() = false
}

class Salida {
    var property position
    const property image = "salida.png"
    var procesandoEntrega = false 

    method interactuarCon(unBombero) {
        if (unBombero.estaCargandoUnCivil() and not procesandoEntrega) {
            procesandoEntrega = true 
            
            unBombero.dejarCivilEnSalida() 
            game.say(unBombero, "¡Un civil a salvo!")
            
            administradorDeNivel.cumplirObjetivo()
            
            estadisticasDelJuego.sumarRescate() 
            
            game.schedule(500, { procesandoEntrega = false }) 
        }
    }

    method esAtravesable() = true
}