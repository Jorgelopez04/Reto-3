// Clase Calculadora
class Calculadora {
    // Suma
    sumar(a: number, b: number): number {
        return a + b;
    }

    // Resta
    restar(a: number, b: number): number {
        return a - b;
    }

    // Multiplicación
    multiplicar(a: number, b: number): number {
        return a * b;
    }

    // División
    dividir(a: number, b: number): number {
        if (b === 0) {
            throw new Error('No se puede dividir entre cero');
        }
        return a / b;
    }
}

// Crear instancia de la calculadora
const calc = new Calculadora();

// Ejemplos de uso
console.log('=== CALCULADORA ===');
console.log(`Suma: 10 + 5 = ${calc.sumar(10, 5)}`);
console.log(`Resta: 10 - 5 = ${calc.restar(10, 5)}`);
console.log(`Multiplicación: 10 * 5 = ${calc.multiplicar(10, 5)}`);
console.log(`División: 10 / 5 = ${calc.dividir(10, 5)}`);
console.log(`División: 20 / 4 = ${calc.dividir(20, 4)}`);