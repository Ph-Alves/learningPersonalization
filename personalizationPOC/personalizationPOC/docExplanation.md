
# Como funciona o codigo
Esse codigo e bem mais simples que o de foundations, ele funciona com um design system dois componentes e uma view principal, o resto e config e codigos simples (fiz um modificador de view tambem que vou explicar sobre ele!)

-
## Design System (a base)
Temos um design system que possui dois enums dentro, um de temas e um de tipografia (um define cores e nome de fonte, outro define fontes e tamanhos.
```
//
//  DesignSystem.swift
//  personalizationPOC
//
//  Created by Paulo Henrique Costa Alves on 07/10/26.
//

import Foundation
import SwiftUI

enum DesignSystem {
    enum Themes: String, CaseIterable, Identifiable {
        var id: Self { self }
        
        case first
        case second
        case third
        case four
        case fifth
        
        var fontName: String {
            switch self {
            case .first: return "BitcountInk-Regular"
            case .second: return "ComicSansMS"
            case .third: return "Isometra-Regular"
            case .four: return "LibreCaslonCondensed-Regular"
            case .fifth: return "Roboto-Regular"
            }
        }
        
        var icon: String {
            switch self {
            case .first:
                return "iconOne"
            case .second:
                return "iconTwo"
            case .third:
                return "iconThree"
            case .four:
                return "iconFour"
            case .fifth:
                return "iconFive"
            }
        }
        
        // Dedicated gradient-stop assets per theme (ThemeX/XGradientStart & XGradientEnd),
        // picked from each palette's darkest and lightest colors.
        var backgroundGradient: LinearGradient {
            let colors: [Color]
            switch self {
            case .first:
                colors = [Color(.oneGradientStart), Color(.oneGradientEnd)]
            case .second:
                colors = [Color(.twoGradientStart), Color(.twoGradientEnd)]
            case .third:
                colors = [Color(.threeGradientStart), Color(.threeGradientEnd)]
            case .four:
                colors = [Color(.fourGradientStart), Color(.fourGradientEnd)]
            case .fifth:
                colors = [Color(.fiveGradientStart), Color(.fiveGradientEnd)]
            }
            return LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom)
        }
        
        var primary: Color {
            switch self {
            case .first:
                return Color(.onePrimary)
            case .second:
                return Color(.twoPrimary)
            case .third:
                return Color(.threePrimary)
            case .four:
                return Color(.fourPrimary)
            case .fifth:
                return Color(.fivePrimary)
            }
        }
        
        var second: Color {
            switch self {
            case .first:
                return Color(.oneSecondary)
            case .second:
                return Color(.twoSecondary)
            case .third:
                return Color(.threeSecondary)
            case .four:
                return Color(.fourSecondary)
            case .fifth:
                return Color(.fiveFifth)
            }
        }
        
        var third: Color {
            switch self {
            case .first:
                return Color(.oneThird)
            case .second:
                return Color(.twoThird)
            case .third:
                return Color(.threeThird)
            case .four:
                return Color(.fourThird)
            case .fifth:
                return Color(.fiveThird)
            }
        }
        
        var four: Color {
            switch self {
            case .first:
                return Color(.oneFourth)
            case .second:
                return Color(.twoFourth)
            case .third:
                return Color(.threeFourth)
            case .four:
                return Color(.fourFourth)
            case .fifth:
                return Color(.fiveFourth)
            }
        }
        
        var five: Color {
            switch self {
            case .first:
                return Color(.oneFifth)
            case .second:
                return Color(.twoFifth)
            case .third:
                return Color(.threeFifth)
            case .four:
                return Color(.fourFifth)
            case .fifth:
                return Color(.fiveFifth)
            }
        }
    }
    
    enum Typography {
        case title
        case body
        case button
        case caption
        
        func font(for theme: Themes) -> Font {
            switch self {
            case .title: return .custom(theme.fontName, size: 28, relativeTo: .title)
            case .body: return .custom(theme.fontName, size: 16, relativeTo: .body)
            case .button: return .custom(theme.fontName, size: 16, relativeTo: .headline)
            case .caption: return .custom(theme.fontName, size: 12, relativeTo: .caption)
            }
        }
    }
}

// TODO: Estudar isso melhor.
struct TypographyModifier: ViewModifier {
    let style: DesignSystem.Typography
    let theme: DesignSystem.Themes
    
    func body(content: Content) -> some View {
        content
            .font(style.font(for: theme))
    }
}

extension View {
    func typography(style: DesignSystem.Typography, theme: DesignSystem.Themes) -> some View {
        modifier(TypographyModifier(style: style, theme: theme))
    }
}

```
e um codigo grande, mas nao precisa se preocupar, o codigo e bem simples, cada variavel e uma computed property (define seu valor dinamicamente) e o enum permite esse armazenamento, e por isso conseguimos fazer essas variaveis bem dinamicas que se baseiam no nosso tema, como as cores de 1 a 5 que cada uma define um valor do asset baseando no valor do tema atual.
No caso de cores, temos uma cor de asset fixo para cada caso e puxamos a cor primaria, secundaria e por ai vai, pelas variaveis e ela puxa a cor correta baseando-se no tema. 
Assim como a font, que muda um pouco, pois definimos o nome da fonte usada com base no tema, mas os valores e a quais fontes da apple elas sao relativas fazemos isso no enum Typography.
e ai que fica legal por que descobri que o enum tambem carrega funçoes que podem ser usadas dentro dele, e no nosso caso e uma funçao que retorna a fonte baseando-se no tema recebido.

Depois disso temos um modificador de view e um extension da view, que serve para podermos criar nosso proprio modificador que podemos usar nas nossas views (mas que vai alterar so texto).
### **Um ponto importante, devemos adicionar no nosso info.plist a chave - Fonts provided by application! E para cada fonte adicionar um item.**
Agora voltando, para podermos usar o modificador de fonte de uma maneira semelhante ao .title .body e por ai vai, criamos esse modificador no final do design system junto ao extension view, por que todos os modificadores de view sao funçoes que rodamos em uma view que retorna essa view alterada, aqui estamos fazendo o mesmo, o ViewModifier modifica a view, o extension e uma forma de rodar o .modifier() que e o que precisa para rodar nosso modificador, assim tornando mais simples rodar ele na view, voce vai entender quando chegar a contentView.

## ContentView
Nosso codigo da contentView e simples mas tem 2 pontos que aprendi no processo:
```
import SwiftUI
import Playgrounds

struct ContentView: View {
    
    @Binding var currentTheme: DesignSystem.Themes
    
    var body: some View {
        VStack {
            Picker("Theme", selection: $currentTheme) {
                ForEach(DesignSystem.Themes.allCases) { theme in
                    Text(theme.rawValue).tag(theme)
                }
            }
            .tint(.primary)
            .onChange(of: currentTheme) { _, newTheme in
                UIApplication.shared.setAlternateIconName(newTheme == .first ? nil : newTheme.icon) { error in
                    if let error {
                        print("Erro ao trocar de ícone: \(error)")
                    }
                }
            }
            
            MyButton(text: "Olha esse botão primário", color: currentTheme.primary)
                .typography(style: .button, theme: currentTheme)
            
            MyButton(text: "Olha esse botão secundário", color: currentTheme.second)
                .typography(style: .button, theme: currentTheme)
            
            MyButton(text: "Olha esse botão terciário", color: currentTheme.third)
                .typography(style: .button, theme: currentTheme)
            
            MyButton(text: "Olha esse botão quaternário", color: currentTheme.four)
                .typography(style: .button, theme: currentTheme)
            
            MyButton(text: "Olha esse botão (quinto)", color: currentTheme.five)
                .typography(style: .button, theme: currentTheme)
            
            
            Spacer()
            
            Text("Olha esse title!")
                .typography(style: .title, theme: currentTheme)
            Text("Olha esse body!")
                .typography(style: .body, theme: currentTheme)
            Text("Olha esse caption!")
                .typography(style: .caption, theme: currentTheme)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    @Previewable @State var currentTheme: DesignSystem.Themes = .first
    ContentView(currentTheme: $currentTheme)
}

```

No nosso caso, pegamos o designSystem (o app instancia e passa pra gente via binding) e listamos todos em um picker, o que permite selecionar e alterar o valor para alterar o tema.
Temos tambem um outro ponto, os icones, que alteram quando o valor de tema altera junto, usando o UIApplication.shared.setAlternateIconName que ja faz isso pra gente, mas temos uma configuraçao no projeto necessaria para se fazer, que e abrir o target, ir em appIcon, definir o icone principal e marcar a caixa que permite todos os arquivos .icon do projeto (temos uma pasta com 5 icones base feitos no icon composes), isso e uma forma mais atualizada de se lidar com icones, que a apple trouxe ao inves de usar AppIcon nos assets.
Depois disso, temos varios buttons, que sao nosso componente, eu nao vou entrar em detalhes por que o componente e bem simples, ele so recebe o color do tema e muda seu background usando esse valor, sem segredo.
Mas aqui que entra nosso modificador, que foi criado no arquivo do designSystem, e podemos usar ele de maneira simples, so com .typography, por que essa funcao ja executa o .modifier com nosso modificador que seria a forma "mais feia de usar" se nao tivessemos aquele extension View.
**Resumindo:** ViewModifier cria o modificador, para alterar um conteudo de certa maneira, o extension view serve para rodar o .modifier necessario e simplificar o processo, deixando o codigo da view mais simples e limpo. 

Depois temos nossos textos, que tambem mudam com esse modificador.
Agora sobre mudar a statusBar, nao conseguimos estilizar a fonte dela, podemos somente esconder a status bar e montar a nossa propria, e pra isso criamos um viewBuilder.
Um @ViewBuilder nada mais e que um construitur de view, ele pega um bloco de codigo de uma funcao e junta tudo isso para voltar um tipo so, como o modificador retorna uma view, podemos usar isso de maneira bem legal, onde definimos qual modificador usar baseando-se na versao do dipositivo (por que no iOS 27, esconder a status bar e outro metodo e os outros foram deprecados. 
```
extension View {
    @ViewBuilder
    func hideStatusBar(_ hidden: Bool) -> some View {
        if #available(iOS 27, *) {
            self.toolbarVisibility(hidden ? .hidden : .visible, for: .statusBar)
        } else {
            self.statusBarHidden(hidden)
        }
    }
}
```
OBS: existe o resultBuilder tambem, bem legal, tipo podemos pegar varias strings separadas sem , e juntar criando nosso proprio resultBuilder, que faz tipo a mesma coisa.
Depois disso, criamos nossa status bar:
```
//
//  newStatusBar.swift
//  personalizationPOC
//
//  Created by Paulo Henrique Costa Alves on 08/10/26.
//

import SwiftUI
public import Combine

struct newStatusBar: View {
    @Binding var theme: DesignSystem.Themes
    
    @State private var now = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private var batteryPercent: Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let level = UIDevice.current.batteryLevel
        return level < 0 ? 0 : Int(level * 100)
    }
    
    var body: some View {
        HStack {
            Text(now, format: .dateTime.hour().minute())
                .typography(style: .body, theme: theme)
            Spacer()
            Text("\(batteryPercent)")
                .typography(style: .caption, theme: theme)
                .padding()
                .overlay() {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(theme.primary, lineWidth: 2)
                }
        }
        .padding(.horizontal, 28)
        .padding(.top, 14)
        .frame(maxWidth: .infinity, alignment: .top)
        .onReceive(timer) {
            now = $0
        }
    }
}

#Preview {
    @Previewable @State var currentTheme: DesignSystem.Themes = .first
    newStatusBar(theme: $currentTheme)
}

```
Ela e um pouco chata de entender por causa do timer, mas vamos parte por parte, primeiro temos que entender que a status bar ela ta escondida, entao a dynamic island vai ficar escondida tambem (se seu app usa, pode nao ser viavel isso).
Primeiro pegamos um tema, depois pegamos a data atual, montamos um timer e pegamos a bateria atual do usuario, que e uma propriedade computada.
Sobre o timer (ele e do proprio Combine), ele e construido a partir da funçao publish dele mesmo que emite um evento a cada 1 segundo, e roda mesmo durante um scroll ou interaçao, e o autoconnect faz disparar assim que alguem se inscreve (o publisher do timer e so a fonte de eventos, ele precisa que alguem se inscreva para receber esses eventos) e para "escutarmos" isso e ai que usamos o onReceive(timer) que e onde minha view se inscreve e recebe esses eventos, e a cada evento (a cada 1 segundo) o { now = $0 } e chamado que e uma forma mais simplificada de escrever:
```
{ (newValue: Date) in
    now = newValue
}

```
Quando uma closure nao nomeia os parametros, podemos referenciar ela usando $0 e $1 como primeiro e segundo parametro e por ai vai.
Sobre a .main no timer, e so que ele vai rodar na thread principal, a mesma onde a UI roda. 
Agora podemos ir para a bateria
```
private var batteryPercent: Int {
    UIDevice.current.isBatteryMonitoringEnabled = true
    let level = UIDevice.current.batteryLevel
    return level < 0 ? 0 : Int(level * 100)
}
```
Pegamos o dispositivo fisico (UIDevice) atual e ligamos o monitoramento de bateria, depois pegamos o nivel de bateria que vem em float entre 0.0 e 1.0 e por isso que temos que multiplicar por 100 e converter para Int pois e um tipo com mais espaço na memoria.
Com isso, so construir a view, sem muito segredo, e algo que eu nao sabia e aprendi e o Text com formatador de data.
```
Text(now, format: .dateTime.hour().minute())
    .typography(style: .body, theme: theme)
```
Pegamos um formatador dateTime, e usamos modificadores encadeados que dizem ao dateTime quais componentes incluir na formataçao.

## Caso queiram animaçoes
O componente myButton mostra como usar uma animaçao com base na troca:
```
struct MyButton: View {
    let text: String
    let color: Color
    
    var body: some View {
        VStack {
            Button(action: {
                
            }, label: {
                Text(text)
            })
            .padding()
            .tint(.white)
            .background(color)
            .animation(.easeInOut(duration: 1.0), value: color)
            .clipShape(Capsule())
            .glassEffect()
        }
    }
}
```
Ele usa o .animation com o valor de cor, e como cor e dinamico e sempre muda com o tema, a view muda tambem na sua reestruturacao
