//
//  TextScreenView.swift
//  SwiftUIHomework5
//
//  Created by Mikhail Kanshin on 19.06.2022.
//

import SwiftUI



struct TextScreenView: View {
    @State var text: String = "Exorcizo te, immundissime spiritus, omnis incursio adversarii, omne phantasma, omnis legio, in nomine Domini nostri Jesu Christi eradicare, et effugare ab hoc plasmate Dei. Ipse tibi imperat, qui te de supernis caelorum in inferiora terrae demergi praecepit. Ipse tibi imperat, qui mari, ventis, et tempestatibus impersvit. Audi ergo, et time, satana, inimice fidei, hostis generis humani, mortis adductor, vitae raptor, justitiae declinator, malorum radix, fomes vitiorum, seductor hominum, proditor gentium, incitator invidiae, origo avaritiae, causa discordiae, excitator dolorum: quid stas, et resistis, cum scias. Christum Dominum vias tuas perdere? Illum metue, qui in Isaac immolatus est, in joseph venumdatus, in sgno occisus, in homine cruci- fixus, deinde inferni triumphator fuit. Sequentes cruces fiant in fronte obsessi. Recede ergo in nomine Patris et Filii, et Spiritus Sancti: da locum Spiritui Sancto, per hoc signum sanctae Cruci Jesu Christi Domini nostri: Qui cum Patre et eodem Spiritu Sancto vivit et regnat Deus, Per omnia saecula saeculorum. Et cum spiritu tuo. Amen."
    
    @Binding var isSuffixScreenActive : Bool
    
    var body: some View {
        VStack {
            ZStack {
                TextEditor(text: $text)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .border(.gray)
            }
            NavigationLink(destination: SuffixScreenView(text: text), isActive: $isSuffixScreenActive) {
                Text("NEXT")
                    .foregroundColor(.blue)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("Text")
        .navigationBarTitle("Text", displayMode: .inline)
        .padding()
    }
}

struct TextScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TextScreenView(isSuffixScreenActive: .constant(false))
    }
}
