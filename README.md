# DLX

### VERSIÓN NO OPTIMIZADA

#### 97

_Tamaño secuencia:_ 119

_Secuencia:_

_Suma Secuencia:_

**vT** = _secuencia_tamanho_ = 7
**vIni** = _valor_inicial_ = 10
**vMax** = _secuencia_maximo_ = 16
**vMed** = _secuencia_valor_medio_ = 6,571428 -> 6,57143
**lista** = [ vIni* vT, vMax*vT, vMed*vT, (vIni/vMax)*vT, (vIni/vMed)*vT, (vMax/vIni)*vT,
(vMax/vMed)*vT, (vMed/vIni)*vT, vMed/vMax)*vT ]
vIni*vT = 70
vMax*vT = 112
vMed*vT = 46
(vIni/vMax)*vT = 4,375
(vIni/vMed)*vT = 10,65217159 -> 10,6522
(vMax/vIni)*vT = 11,2
(vMax/vMed)*vT = 17,0435
(vMed/vIni)*vT = 4,6
(vMed/vMax)*vT = 2,875

#### 66

_Tamaño secuencia:_ 

_Secuencia:_

_Suma Secuencia:_

**vT** = _secuencia_tamanho_ = 
**vIni** = _valor_inicial_ = 
**vMax** = _secuencia_maximo_ = 
**vMed** = _secuencia_valor_medio_ = 
**lista** = [ vIni* vT, vMax*vT, vMed*vT, (vIni/vMax)*vT, (vIni/vMed)*vT, (vMax/vIni)*vT,
(vMax/vMed)*vT, (vMed/vIni)*vT, vMed/vMax)*vT ]
vIni*vT = 
vMax*vT = 
vMed*vT = 
(vIni/vMax)*vT = 
(vIni/vMed)*vT = 
(vMax/vIni)*vT = 
(vMax/vMed)*vT = 
(vMed/vIni)*vT = 
(vMed/vMax)*vT = 


#### 10 

_Tamaño secuencia:_ 7

_Secuencia:_ 10-5-16-8-4-2-1

_Suma secuencia:_ 46

**vT** = _secuencia_tamanho_ = 7
**vIni** = _valor_inicial_ = 10
**vMax** = _secuencia_maximo_ = 16
**vMed** = _secuencia_valor_medio_ = 6,571428 -> 6,57143
**lista** = [ vIni * vT, vMax * vT, vMed * vT, (vIni / vMax) * vT, (vIni / vMed) * vT, (vMax / vIni) * vT,
(vMax / vMed) * vT, (vMed / vIni) * vT, vMed / vMax) * vT ]
vIni * vT = 70
vMax * vT = 112
vMed * vT = 46
(vIni /vMax) * vT = 4,375
(vIni /vMed) * vT = 10,65217159 -> 10,6522
(vMax / vIni) * vT = 11,2
(vMax / vMed) * vT = 17,0435
(vMed / vIni) * vT = 4,6
(vMed / vMax) * vT = 2,875

Estadisticas | VersionNoOptimizada | VersionOptimizada
:---------:|:----------:|:---------:
 Ciclos | 447 | b1
 RAW Stalls | 221 = 49.44% of all Cycles| b2
 LD Stalls | 7 = 3.17% of RAW Stalls| b3
 Branch/Jump Stalls | 20 = 9.05% of RAW Stalls| b4
 Floating Point Stalls | 194 = 87.78% of RAW Stalls| b5
 WAW Stalls | 0 = 0.0% of all cycles| b6
 Structural Stalls | 0 = 0.0% of all cycles| b7
 Control Stalls | 25 = 5.59% of all cycles| b8
 Trap Stalls | 2 = 0.45% of all cycles| b9
 Total | 248 Stalls = 55.48% of all cycles | b10

 De estos datos podemos ver que donde más ciclos gastamos es en las operaciones floats
