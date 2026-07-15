import escenarios.*
import civiles_y_fuego.*
import logros.*

object bombero {
    var  position = game.at(1,0)
    var  agua = 0
    var  energia = 100
    var property estaCargandoUnCivil = false 
    var property estaEnMinijuego = false

    method position() = position
    method position(nuevaPosicion) {
        if (!estaEnMinijuego) {
            position = nuevaPosicion
        }
    }
    
    method image() = if (estaCargandoUnCivil) "bomberoRescate.png" else "bomberoPersonaje.png"

    method energia() = energia
    method agua() = agua

    method prepararNivel(nuevaPosicion, nuevaEnergia, cantAgua) {
        position = nuevaPosicion
        energia = nuevaEnergia
        agua = cantAgua
        estaCargandoUnCivil = false
    }

    method seQuedoSinEnergia(){
        return self.energia() == 0
    }

    method fallarSiSeAgoto(){
        if (self.seQuedoSinEnergia()) {
            administradorDeNivel.perderJuego() 
        }
    }
 

    method cansarse() { 
        energia = (energia - 1).max(0)
        self.fallarSiSeAgoto()
    }



    method quemarse(cantidad) {
        energia = (energia - cantidad).max(0)
        self.fallarSiSeAgoto()  
    }

    method puedeIrA(nuevaPosicion) {
        const objetoEnPosicion = game.getObjectsIn(nuevaPosicion)

        return objetoEnPosicion.all({o => o.esAtravesable()})
    }
    method subir() {
        const proximo = position.up(1)

        if (self.puedeIrA(proximo)){
            self.position(proximo)
            self.cansarse()
        }
        
    }
    method bajar() {
        const proximo = position.down(1)

        if (self.puedeIrA(proximo)){
            self.position(proximo)
            self.cansarse()
        }
        
    }
    method derecha() {
        const proximo = position.right(1)

        if (self.puedeIrA(proximo)){
            self.position(proximo)
            self.cansarse()
        }
        
    }
    method izquierda() {
        const proximo = position.left(1)

        if (self.puedeIrA(proximo)){
            self.position(proximo)
            self.cansarse()
        }
        
    }

    method rescatar(civil) {
        if (estaCargandoUnCivil) {
            game.say(self, "Antes tengo que dejar al civil en un lugar seguro")
        } 
        else {
            estaCargandoUnCivil = true
            game.removeVisual(civil)
        }
    }
    
    method dejarCivilEnSalida() {
        estaCargandoUnCivil = false
    }

         
    method apagar(fuego){
    
        agua = agua - 1
        self.cansarse()
        game.removeVisual(fuego)
        administradorDeNivel.cumplirObjetivo()
        logro.sumarIncendiosApagados()
    
    }


    method cargarAgua(){
        agua = 5 
        game.say(self, "Manguera cargada!")
    }
   


}

object energiaBombero {
    var property position = game.at(2, 14)
    method text() = "Energía Restante:" + " " + bombero.energia().toString()
    method textColor() = "FFFFFFFF"
    method interactuarCon(bombero) {}

    method esAtravesable() = true
}
object cantidadDeAguaBombero {
    var property position = game.at(2, 13)
    method text() = "Agua Restante:" + " " + bombero.agua().toString()
    method textColor() = "FFFFFFFF"
    method interactuarCon(bombero) {}

    method esAtravesable() = true
}

class Salida {
    var property position
    const property image = "salida.png"

    method interactuarCon(bombero) {
        if (bombero.estaCargandoUnCivil()) {
            bombero.dejarCivilEnSalida()
            game.say(bombero, "Un civil menos")
            administradorDeNivel.cumplirObjetivo()
            logro.sumarRescate()
        }
    }

    method esAtravesable() = true
}