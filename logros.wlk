object estadisticasDelJuego {
    var rescatados = 0
    var incendiosApagados = 0
    const nivelesCompletados = [] 

    method rescatados() = rescatados
    method incendiosApagados() = incendiosApagados
    
    method sumarRescate() {
        rescatados = rescatados + 1
    }
    
    method sumarIncendioApagado() {
        incendiosApagados = incendiosApagados + 1
    }

    method completarNivel(numeroDeNivel) {
        if (not nivelesCompletados.contains(numeroDeNivel)) {
            nivelesCompletados.add(numeroDeNivel)
        }
    }

    method nivelEstaCompleto(numeroDeNivel) {
        return nivelesCompletados.contains(numeroDeNivel)
    }
}

class Logro {
    var property position
    
    method estaCompleto() 
    
    method image() {
        return if (self.estaCompleto()) "logroCompleto.png" else "logroIncompleto.png"
    }
}

class LogroNivel inherits Logro {
    const nivelObjetivo 

    override method estaCompleto() {
        return estadisticasDelJuego.nivelEstaCompleto(nivelObjetivo)
    }
}


class LogroRescates inherits Logro {
    const meta

    override method estaCompleto() {
        return estadisticasDelJuego.rescatados() >= meta
    }
}

class LogroIncendios inherits Logro {
    const meta

    override method estaCompleto() {
        return estadisticasDelJuego.incendiosApagados() >= meta
    }
}

object trofeo {
    var property position = game.at(1, 1)
    method image() = "trofeoOro.png"
}