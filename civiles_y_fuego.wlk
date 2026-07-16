import escenarios.*
import minijuegoTiming.*


class Elemento {

    method interactuarCon(bombero)
    method esAtravesable()
}


class Civil inherits Elemento {
    var property position
    const property image
    var estaSiendoRescatado = false
    var yaFueEntregado = false 

    override method interactuarCon(bombero) {
 
        if (not estaSiendoRescatado and not bombero.estaCargandoUnCivil()) {
            estaSiendoRescatado = true
            bombero.rescatar(self) 
            
    
            self.position(nivelFacil.salida().position())
        }
       
        if (estaSiendoRescatado and not yaFueEntregado and bombero.position() == nivelFacil.salida().position()) {
            yaFueEntregado = true 
            estaSiendoRescatado = false
            
            bombero.dejarCivilEnSalida()
            game.say(bombero, "¡Un civil a salvo!")
      
            administradorDeNivel.cumplirObjetivo()
            
            
            game.removeVisual(self) 
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
                minijuegoTiming.iniciar(self)
                estaSiendoApagado = true 
            } 
            else {
                bombero.quemarse(daño)
                game.say(bombero, "¡Auch, no tengo agua y me quemé!")
            }
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