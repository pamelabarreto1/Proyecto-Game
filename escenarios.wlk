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

const salida = new Salida()

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
const posicionDeMuros = [game.at(0, 0), game.at(0, 1), game.at(0, 2), game.at(0, 3), game.at(0, 4), 
    game.at(0, 5), game.at(0, 6), game.at(0, 7), game.at(0, 8), game.at(0, 9), 
    game.at(0, 10), game.at(0, 12), game.at(0, 13), game.at(0, 14), game.at(0, 15),
    game.at(1, 1), game.at(1, 2), game.at(1, 5), game.at(1, 7), game.at(1, 15), 
    game.at(2, 0), game.at(2, 5), game.at(2, 7), game.at(2, 15),
    game.at(3, 0), game.at(3, 5), game.at(3, 6), game.at(3, 7), game.at(3, 10), 
    game.at(3, 12), game.at(3, 15),
    game.at(4, 0), game.at(4, 9), game.at(4, 10), game.at(4, 15),
    game.at(5, 0), game.at(5, 4), game.at(5, 9), game.at(5, 10), game.at(5, 15),
    game.at(6, 0), game.at(5, 4), game.at(6, 14), game.at(6, 15),
    game.at(7, 0), game.at(7, 10), game.at(7, 14), game.at(7, 15),
    game.at(8, 0), game.at(8, 10), game.at(8, 15),
    game.at(9, 0), game.at(9, 15),
    game.at(10, 0), game.at(10, 15),
    game.at(11, 0), game.at(11, 15),
    game.at(12, 0), game.at(12, 1), game.at(12, 2), game.at(12, 14), game.at(12, 15),
    game.at(13, 0), game.at(13, 3), game.at(13, 14), game.at(13, 15),
    game.at(14, 0), game.at(14, 3), game.at(14, 14), game.at(14, 15),
    game.at(15, 0), game.at(15, 1), game.at(15, 2), game.at(15, 3), game.at(15, 4), 
    game.at(15, 5), game.at(15, 6), game.at(15, 7), game.at(15, 8), game.at(15, 9), 
    game.at(15, 10), game.at(15, 11), game.at(15, 12), game.at(15, 13), game.at(15, 14), 
    game.at(15, 15)]

const civil1 = new Civil(position = game.at(3, 5), image = "civil2.png")
const civil = new Civil(position = game.at(5, 3), image = "civil.png")
const flama0 = new Fuego(position = game.at(2, 6), daño = 40)
const flama1 = new Fuego(position = game.at(4, 2), daño = 40)   //le agregué el daño a 40 para complejizar el juego
const flama2 = new Fuego(position = game.at(6, 5), daño = 40)
const flama3 = new Fuego(position = game.at(1, 1), daño = 40)

const salida = new Salida(position = game.at(0, 11))

// iniciamos desde las opciones del menu

    method iniciar() {

// primero se agrega el fondo

    game.addVisual(fondoNivel_2)

    posicionDeMuros.forEach({p => game.addVisual(new MuroInvisible(position = p))})

    bombero.prepararNivel(game.at(1, 11) , 9000, 0)

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

    keyboard.p().onPressDo({ 
            console.println("game.addVisual(new Muro(position = game.at(" + bombero.position().x() + ", " + bombero.position().y() + ")))")
        })
    

    game.onCollideDo(bombero, {
        objeto => objeto.interactuarCon(bombero)
        })
    }
}

