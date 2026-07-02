import wollok.game.*
import bombero.*
import civiles_y_fuego.*
import fondos.*

class AdministradorDeNivel {
    var property objetosPendientes 

    method cumplirObjetivo() {
        objetosPendientes = objetosPendientes - 1

        if (objetosPendientes == 0) {
            game.say(bombero, "¡Misión Cumplida! Ganaste.")

            if (gestorDeNivel.nivelActual() == 1) {
                game.say(bombero, "Hay otros civiles que rescatar.")
                game.schedule(2500, {
                    game.clear()
                    nivelDificil.iniciar()})
            }
            else {
            game.say(bombero, "¡Misión Cumplida! Ganaste.")
            game.schedule(500, {
                    game.stop()
                })
            }
        }
        
    }
}

const administradorDeNivel1 = new AdministradorDeNivel (objetosPendientes = 2)
object gestorDeNivel {
    var property nivelActual = 0
}

object menu {
    method iniciar() {
        game.addVisual(fondoMenu)
        keyboard.f().onPressDo { self.empezarJuegoFacil() }
        keyboard.d().onPressDo { self.empezarJuegoDificil() }
    }
    method empezarJuegoFacil() {
        game.clear()
        gestorDeNivel.nivelActual(1)
        nivelFacil.iniciar()
    }
    method empezarJuegoDificil() {
        game.clear()
        gestorDeNivel.nivelActual(2)
        nivelDificil.iniciar()
    }
}
// ambos niveles son iguales, hay que cambiarlos.
object nivelFacil {

const civil1 = new Civil(position = game.at(3, 5), image = "civil2.png")
const civil = new Civil(position = game.at(5, 3), image = "civil.png")

const flama0 = new Fuego(position = game.at(1, 4))
const flama1 = new Fuego(position = game.at(3, 3))
const flama2 = new Fuego(position = game.at(5, 4))
const flama3 = new Fuego(position = game.at(2, 3))

    method iniciar() {

    game.addVisual(fondoNivel_1)
    
    game.addVisual(energiaBombero)
    game.addVisual(civil1)
    game.addVisual(civil)
    game.addVisual(lago)
    game.addVisual(flama0)
    game.addVisual(flama2)
    game.addVisual(flama1)
    game.addVisual(flama3)
    game.addVisual(bombero)
    game.addVisual(salida)

    keyboard.w().onPressDo({bombero.subir()})
    keyboard.s().onPressDo({bombero.bajar()})
    keyboard.d().onPressDo({bombero.derecha()})
    keyboard.a().onPressDo({bombero.izquierda()})
    

    game.onCollideDo(bombero, {
        objeto => objeto.interactuarCon(bombero)
        })


    }
}

object nivelDificil {

// Creamos los objetos a usar en el nivel

const civil1 = new Civil(position = game.at(3, 5), image = "civil2.png")
const civil = new Civil(position = game.at(5, 3), image = "civil.png")
const flama0 = new Fuego(position = game.at(2, 6), daño = 40)
const flama1 = new Fuego(position = game.at(4, 2), daño = 40)   //le agregué el daño a 40 para complejizar el juego
const flama2 = new Fuego(position = game.at(6, 5), daño = 40)
const flama3 = new Fuego(position = game.at(1, 1), daño = 40)

// iniciamos desde las opciones del menu

    method iniciar() {

// primero se agrega el fondo

    game.addVisual(fondoNivel_1)

    game.addVisual(energiaBombero)
    game.addVisual(civil1)
    game.addVisual(civil)
    game.addVisual(flama0)
    game.addVisual(flama2)
    game.addVisual(flama1)
    game.addVisual(flama3)
    game.addVisual(lago)
    game.addVisual(bombero)
    game.addVisual(salida)

    keyboard.w().onPressDo({bombero.subir()})
    keyboard.s().onPressDo({bombero.bajar()})
    keyboard.d().onPressDo({bombero.derecha()})
    keyboard.a().onPressDo({bombero.izquierda()})


    

    game.onCollideDo(bombero, {
        objeto => objeto.interactuarCon(bombero)
        })
    }
}