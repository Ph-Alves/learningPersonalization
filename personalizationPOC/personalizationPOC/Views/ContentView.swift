import SwiftUI
import Playgrounds

/*
 Objetivo
 Validar a criação de um sistema de personalização visual que permita adaptar a identidade do app a diferentes temas.

 Escopo

 Criar 4 temas visuais distintos.

 Adaptar para cada tema:
    Ícones;
    Tipografia;
    Paleta de cores;
    Elementos visuais da interface;
    Elementos do sistema, como Status Bar (hora, bateria, sinal etc.).
 
 - Estruturar o sistema para que os componentes do app se adaptem automaticamente ao tema selecionado.
 - Garantir consistência visual entre as telas, componentes e elementos do sistema.
 - Validar a troca de tema em tempo de execução.
 - Garantir que os elementos nativos, como a Status Bar, também respeitem a identidade visual de cada tema.

 Critério de aceite
 POC funcional com 4 temas, em que a seleção de um tema altera automaticamente ícones, fontes, cores, elementos da interface e elementos do sistema (como Status Bar), mantendo a consistência visual em todo o app.
 */

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
        .hideStatusBar(true)
        .overlay(alignment: .top) {
            newStatusBar(theme: $currentTheme)
                .ignoresSafeArea(edges: .top)
        }
    }
}

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

#Preview {
    @Previewable @State var currentTheme: DesignSystem.Themes = .first
    ContentView(currentTheme: $currentTheme)
}

#Playground {
    _ = 1 + 2
}
