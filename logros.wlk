object logro {
    var rescatados = 0
    var incendiosApagados = 0
    method rescatados() = rescatados
    method incendiosApagados() = incendiosApagados
    method sumarRescate() {
        rescatados = rescatados + 1
    }
    method sumarIncendiosApagados() {
        incendiosApagados = incendiosApagados + 1
    }
}

class Logro {
    var property position
    method estaCompleto()
    method image() = if (self.estaCompleto()) "logroCompleto.png" else "logroIncompleto.png"
}

class LogroNiveles inherits Logro {
    override method estaCompleto() {
        return true
    }
}

class LogroRescates inherits Logro {
    const metaRescates
    override method estaCompleto() {
        return metaRescates <= logro.rescatados()
    }
}

class LogroIncendios inherits Logro {
    const metaApagar
    override method estaCompleto() {
        return metaApagar <= logro.incendiosApagados()
    }
}

object trofeo {
    var property position = game.at(1, 1)
    method image() ="trofeoOro.png"
}

// hacer que no empieze el nivel mientras este en la pestaña de logros